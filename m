From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jan 2012 16:55:42 +0800
Subject: [PATCH resent v2 1/2] ioport : add DEFINE_RES_DMA_SIZE_NAMED macro
In-Reply-To: <4F17D40F.3080803@freescale.com>
References: <1326959620-25920-1-git-send-email-b32955@freescale.com>
 <1326959620-25920-2-git-send-email-b32955@freescale.com>
 <20120119081427.GF2247@S2101-09.ap.freescale.net>
 <4F17D2ED.6090502@freescale.com> <4F17D40F.3080803@freescale.com>
Message-ID: <20120119085539.GG2247@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 04:27:59PM +0800, Huang Shijie wrote:
> 
> >Hi Shawn:
> >>I'm not sure the patch is welcomed.  You may want to just use
> >>DEFINE_RES_NAMED for such cases.
> >I ever wanted to use DEFINE_RES_NAMED.
> sorry. I misunderstood your meaning.
> 
> I think it's better to add a new macro. use DEFINE_RES_NAMED is not proper.
> 
In that case, I can not apply the patch #2 until #1 hits mainline, so
remember to ping me for applying patch #2 when the first one gets
merged.

-- 
Regards,
Shawn
