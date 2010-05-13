From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 14 May 2010 08:22:48 +0900
Subject: [PATCH 2.6.35] ARM: S3C6410: Add missing definitions for the
	IISv4 clock
In-Reply-To: <1273771379-5729-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1273771379-5729-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <AANLkTik-y2JU4w1m6muo6pez97nE_XY4fQPRuQkwExza@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 2:22 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Commit 301176 ("Declare IISv4 audio-bus clock") requires both the
> register S3C6410_CLK_SRC2 and the clkset for the IISv4 audio bus but
> neither of those is defined in mainline. ?Add definitions, including the
> addition of the PCMCDCLK[1] and the CDCLK for the IISv4 block both of
> which are first used by this clock.
Hi Ben,
  Seems you missed the first three in the series?
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011036.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011039.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011038.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011037.html

I am ok with this Mark's single patch too though.

Thanks.
