From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 23 Sep 2013 21:03:50 +0300
Subject: [PATCH 1/3] ARM: OMAP2: HACK: hardcode hsmmc2 input clock source
 for N950/N9
In-Reply-To: <20130923173843.GI2684@atomide.com>
References: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
 <1379771142-29087-2-git-send-email-aaro.koskinen@iki.fi>
 <20130923173843.GI2684@atomide.com>
Message-ID: <20130923180350.GA17450@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 23, 2013 at 10:38:43AM -0700, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [130921 06:56]:
> > Without this the eMMC (root file system) cannot be used on N950/N9.
> > Any ideas for a proper solution?

> Can you please update this patch on the quirks series I posted
> few days ago?

Ok, will do (sorry I missed that series).

Thanks,

A.
