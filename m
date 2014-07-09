From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 9 Jul 2014 10:22:29 -0700
Subject: [PATCH] mtd: nand: stm_nand_bch: add new driver
In-Reply-To: <20140708095855.29c2fb87@bbrezillon>
References: <1401268805-26043-1-git-send-email-lee.jones@linaro.org>
 <20140703002237.GM3599@ld-irv-0074>
 <20140703100522.756f9715@bbrezillon>
 <20140707235222.GC7537@ld-irv-0074>
 <20140708095855.29c2fb87@bbrezillon>
Message-ID: <20140709172229.GH7537@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Tue, Jul 08, 2014 at 09:58:55AM +0200, Boris BREZILLON wrote:
> On Mon, 7 Jul 2014 16:52:22 -0700 Brian Norris <computersforpeace@gmail.com> wrote:
> > On Thu, Jul 03, 2014 at 10:05:22AM +0200, Boris BREZILLON wrote:
> > > On Wed, 2 Jul 2014 17:22:37 -0700 Brian Norris <computersforpeace@gmail.com> wrote:
> > > 
> > > AFAIR, the NAND timing representation for non-ONFI chips question was
> > > left unanswered:
> > > 
> > > https://lkml.org/lkml/2014/5/20/581
> > > 
> > > I can definitely respin my NAND timings series, but I'd like to be sure
> > > this is how you want it done before doing so.
> > 
> > Can we start by supporting ONFI-only (or ONFI-only, plus entries in
> > nand_flash_ids[]), and have nand_base provide the translation so drivers
> > can retrieve the info? Then we can begin supporting new drivers like
> > Lee's, and worry about the DT question separately.
> 
> So, basically, I just send a new series with patch 1 and 2 from my sunxi
> NAND series [1] (including the fixes you suggested, of course), right ?
> 
> [1] http://thread.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7977

Yes, please send 1 and 2 on their own. I think that would be a good
start for supporting these drivers.

Brian
