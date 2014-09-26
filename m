From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 26 Sep 2014 14:15:00 +0200
Subject: ARM: meson: MESON6_TIMER?
Message-ID: <1411733700.7866.29.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

Your commit 3b8f5030ddcf ("ARM: meson: add basic support for MesonX
SoCs") landed in next-20140926. It adds (among other things) a select
statement:
    select MESON6_TIMER

But there's no Kconfig symbol MESON6_TIMER (in next-20140926). I assume
that this symbol is queued somewhere. (Probably related is the currently
orphaned DT string "amlogic,meson6-timer".) Is that correct?


Paul Bolle
