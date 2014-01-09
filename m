From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Jan 2014 09:42:11 +0800
Subject: [PATCH] ARM: i.MX51: Fix IOMUX settings
In-Reply-To: <20140108222947.65b0759f4efd2c40b7136c31@mail.ru>
References: <1388550301-31215-1-git-send-email-shc_work@mail.ru>
 <20140106061233.GE27227@S2101-09.ap.freescale.net>
 <20140108222947.65b0759f4efd2c40b7136c31@mail.ru>
Message-ID: <20140109014209.GA21717@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 10:29:47PM +0400, Alexander Shiyan wrote:
> Hello.
> 
> On Mon, 6 Jan 2014 14:12:37 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Wed, Jan 01, 2014 at 08:25:01AM +0400, Alexander Shiyan wrote:
> > > This patch fix daisy channel settings for MX51_PAD_EIM_D26__UART3_TXD and
> > > MX51_PAD_AUD3_BB_FS__UART3_TXD pads. Add missing SION bit for W1 pad.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > 
> > Normally, we do not take non-DT platform code change anymore.  But since
> > it's a simple fix, I applied it.
> 
> Shawn, please revert this patch completely since it breaks work some current boards.
> Lets keep it as is.

Okay, dropped.

Shawn
