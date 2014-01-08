From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 7 Jan 2014 18:15:47 -0600
Subject: [RESEND PATCHv8 3/4] mmc: dw_mmc-socfpga: Remove the SOCFPGA
 specific platform for dw_mmc
In-Reply-To: <20140107201721.GK20094@book.gsilab.sittig.org>
References: <1389036754-7249-1-git-send-email-dinguyen@altera.com>
 <1389036754-7249-4-git-send-email-dinguyen@altera.com>
 <20140107201721.GK20094@book.gsilab.sittig.org>
Message-ID: <1389140147.26863.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerhard,

On Tue, 2014-01-07 at 21:17 +0100, Gerhard Sittig wrote:
> On Mon, Jan 06, 2014 at 13:32 -0600, dinguyen at altera.com wrote:
> > 
> > ---
> >  drivers/mmc/host/Kconfig          |    8 ---
> >  drivers/mmc/host/dw_mmc-socfpga.c |  138 -------------------------------------
> >  2 files changed, 146 deletions(-)
> >  delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c
> 
> Isn't a Makefile affected when you remove a config option and the
> whole source file which depends on the option?  Running
> 
>   git grep MMC_DW_SOCFPGA
> 
> on v3.13-rc7-55-gef350bb7c5e0 suggests that
> drivers/mmc/host/Makefile needs an update as well.

Yes, thanks for catching that. Will fix in v9.

Dinh
> 
> 
> virtually yours
> Gerhard Sittig
