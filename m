From: carlo@caione.org (Carlo Caione)
Date: Fri, 26 Sep 2014 14:21:31 +0200
Subject: ARM: meson: MESON6_TIMER?
In-Reply-To: <1411733700.7866.29.camel@x220>
References: <1411733700.7866.29.camel@x220>
Message-ID: <CAOQ7t2Y0+OMab1CGGegUU+oOPaw=_NAxwM0LKn9GpiMZqAFnvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 2:15 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> Hi Carlo,

Hi Paul,

> Your commit 3b8f5030ddcf ("ARM: meson: add basic support for MesonX
> SoCs") landed in next-20140926. It adds (among other things) a select
> statement:
>     select MESON6_TIMER
>
> But there's no Kconfig symbol MESON6_TIMER (in next-20140926). I assume
> that this symbol is queued somewhere. (Probably related is the currently
> orphaned DT string "amlogic,meson6-timer".) Is that correct?

Yes. The timer support is going to be added with:

http://www.spinics.net/lists/arm-kernel/msg362483.html

Daniel is already on it.

-- 
Carlo Caione
