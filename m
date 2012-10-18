From: grant.b.edwards@gmail.com (Grant Edwards)
Date: Thu, 18 Oct 2012 14:00:46 +0000 (UTC)
Subject: PDF documentation
References: <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com>
 <508003AA.8010409@ahsoftware.de> <E1TOqZc-0005Wc-Oj@jdl.com>
Message-ID: <k5p22e$7d1$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-10-18, Jon Loeliger <jdl@jdl.com> wrote:
>> 
>> I would prefer if the source for the (PDF-)documentation would be
>> available in some open, free and widely used meta-language, e.g. LaTeX
>> (or XML or txt2tags or ..., but I'm oldschool and prefer LaTeX ;) ). So
>> everyone could build it's copy in whatever format he prefers or needs.
>
> Perhaps DocBook?  It is readily rendered as PDF or HTML.

Unfortunately DocBook can't be read/edited by a human.  IMO, Docbook
is only suitable as a machine-generated intermediate format.

I'd recommend one of the lightweight markup languages like asciidoc or
reStructuredText.  They're easy to read/write, perfectly usable in the
source form and can be rendered into PDF, HTML, ODT, DocBook, whatever.

-- 
Grant Edwards               grant.b.edwards        Yow! Don't SANFORIZE me!!
                                  at               
                              gmail.com            
