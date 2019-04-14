%
% Template:
%   - name: mybeamer
%   - category: beamer
%   - date: 2019-03-27 16:36:50 +0800
%   - commit: acae34ab6d1d36e786f7448e1cf751ffca5db610
%
% Copyright (C) 2014-2019 by Xu Cheng <xucheng@me.com>
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%    http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Xu Cheng.
%

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{mybeamer}

\RequirePackage{xifthen}
\RequirePackage{xkeyval}
\RequirePackage{xkvltxp}

\newif\if@biblatex
\@biblatexfalse
\DeclareOptionX{biblatex}[]{
    \@biblatextrue
    \ifthenelse{\equal{#1}{}}{
        \PassOptionsToPackage{style=ieee-alphabetic,giveninits=true,maxnames=10,dashed=false}{biblatex}
        }{
        \PassOptionsToPackage{#1}{biblatex}
    }
}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptionsX%
\PassOptionsToPackage{table,dvipsnames}{xcolor}
\LoadClass[compress,xcolor]{beamer}

% Check for obsoleted LaTeX packages
\RequirePackage[l2tabu,orthodox]{nag}

% Utility packages
\RequirePackage{calc}
\RequirePackage{datenumber}
\RequirePackage{etoolbox}
\RequirePackage{iftex}
\RequirePackage{ragged2e}
\RequirePackage{xparse}
\RequirePackage{xpatch}
\RequirePackage{xstring}
\ifPDFTeX\RequirePackage{linegoal}\fi


% Better text justifying
\ifLuaTeX\RequirePackage{luatexbase}\fi% workaround issue: https://tex.stackexchange.com/q/476740/16996
\RequirePackage{microtype}

% Color packages
\RequirePackage{color}
\RequirePackage[table,dvipsnames]{xcolor}

% Math related packages
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\let\emptyset\varnothing%
\RequirePackage{amsfonts}
\RequirePackage{mathrsfs}
\RequirePackage{latexsym}
\RequirePackage{fancynum}
\setfnumgsym{\,}
\RequirePackage[ruled,vlined]{algorithm2e}
\SetVlineSkip{0pt}

\RequirePackage{subcaption}

% Figure related packages
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{overpic}

% Table related packages
\RequirePackage{array}
\RequirePackage{tabu}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}

% Fancy box
\RequirePackage{tcolorbox}

% hyperref setting
\RequirePackage{hyperref}
\RequirePackage[capitalise]{cleveref}
\hypersetup{
    unicode,
    psdextra,
    bookmarksnumbered=true,
    bookmarksopen=true,
    bookmarksopenlevel=3,
    pdfinfo={
        Template.name={mybeamer},
        Template.author={Xu Cheng <xucheng@me.com>},
        Template.category={beamer},
        Template.date={2019-03-27 16:36:50 +0800}, % chktex 8
        Template.commit={acae34ab6d1d36e786f7448e1cf751ffca5db610},
        Template.url={https://github.com/xu-cheng/latex},
    },
    pdfcenterwindow=true,
    pdfstartview={Fit},
    pdfpagemode={FullScreen},
    pdfpagelayout={SinglePage},
}
\RequirePackage{bookmark}

% Skip between equation and context
% Ref: https://tex.stackexchange.com/a/69678
\newcommand{\@setdisplayskip}{
\abovedisplayskip=0.25\baselineskip% chktex 1
\abovedisplayshortskip=0pt plus 0.25\baselineskip% chktex 1
\belowdisplayskip=0.25\baselineskip% chktex 1
\belowdisplayshortskip=0.25\baselineskip% chktex 1
}
\xapptocmd\Huge{\@setdisplayskip}{}{}
\xapptocmd\huge{\@setdisplayskip}{}{}
\xapptocmd\LARGE{\@setdisplayskip}{}{}
\xapptocmd\Large{\@setdisplayskip}{}{}
\xapptocmd\large{\@setdisplayskip}{}{}
\xapptocmd\normalsize{\@setdisplayskip}{}{}
\xapptocmd\small{\@setdisplayskip}{}{}
\xapptocmd\footnotesize{\@setdisplayskip}{}{}
\xapptocmd\scriptsize{\@setdisplayskip}{}{}
\xapptocmd\tiny{\@setdisplayskip}{}{}


% Utility function
\RequirePackage{soul} % offers \hl
\newcommand*{\email}[1]{\href{mailto:#1}{\texttt{#1}}}
\newcommand{\todo}[1]{{\color{red} TODO:\ #1}}

% Beamer theme
\usetheme{metropolis}
\metroset{block=fill,numbering=fraction}
\RequirePackage{appendixnumberbeamer}

\setbeamerfont{caption}{size=\scriptsize}
\renewcommand{\figurename}{Fig.}

% Justify text inside list environment
% Ref: http://liam0205.me/2017/04/11/justifying-in-beamer-s-lists/
\xpatchcmd{\itemize}{\raggedright}{\justifying}{}{}
\xpatchcmd{\beamer@enum@}{\raggedright}{\justifying}{}{}
\xpatchcmd{\@@description}{\raggedright}{\justifying}{}{}

% Beamer TOC
\newcommand{\PrintTOC}{
    \begin{frame}{\contentsname}
        \setbeamertemplate{section in toc}[sections numbered]
        \tableofcontents[hideallsubsections]
    \end{frame}
}

% Bibliography
\if@biblatex
    \RequirePackage{biblatex}
    % url break in bibliography
    \setcounter{biburllcpenalty}{1}
    \setcounter{biburlucpenalty}{1}
    \setcounter{biburlnumpenalty}{1}
    \newcommand{\PrintRef}{
        \begingroup
        \setbeamertemplate{frametitle continuation}{}
        \begin{frame}[t,allowframebreaks]{\refname}
            \bookmark[page=\thepage,startatroot]{\refname}
            \setbeamertemplate{bibliography item}[text]
            \renewcommand*{\bibfont}{\scriptsize}
            \printbibliography[heading=none]%
        \end{frame}
        \endgroup
    }
\fi

% Thanks Q&A page
\newcommand{\PrintQA}{
    \begin{frame}[standout]
        Thanks \\
        Questions?
    \end{frame}
}
