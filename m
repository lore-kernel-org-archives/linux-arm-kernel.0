From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Dec 2011 11:10:33 +0000
Subject: [PATCH v2 1/7 v2] ARM: OMAP1: ams-delta: register latch
 dependent devices later
In-Reply-To: <4EF30F9C.7030708@bitmer.com>
References: <201112200028.32947.jkrzyszt@tis.icnet.pl>
 <201112212051.13113.jkrzyszt@tis.icnet.pl>
 <20111221200728.GG24444@atomide.com>
 <201112221139.16317.jkrzyszt@tis.icnet.pl>
 <4EF30F9C.7030708@bitmer.com>
Message-ID: <20111222111032.GK4546@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 01:08:12PM +0200, Jarkko Nikula wrote:
> On 12/22/2011 12:39 PM, Janusz Krzysztofik wrote:

Guys *please* delete irrelevant context from mails.  I wasn't reading
any of the rest of it since nothing about the subject line says anything
about anything relevant and there was no content anywhere near the start
of the actual mails.  I only saw this because Jarkko did trim the
context.

> >Jarkko, Mark or Liam, care to ack this change, moving the Amstrad Delta
> >sound card registration to late_initcall?

> Unfortunately I haven't had time to look at the series but I'm fine
> with sound/soc/omap/ams-delta.c change.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
