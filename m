From: tj@kernel.org (Tejun Heo)
Date: Tue, 4 Mar 2014 09:04:09 -0500
Subject: [PATCH v3 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <4575362.nxyAcPCJSW@amdc1032>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <1393328481-7251-3-git-send-email-lee.jones@linaro.org>
 <20140226144721.GP9195@lee--X1> <4575362.nxyAcPCJSW@amdc1032>
Message-ID: <20140304140409.GA30338@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 02:48:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, February 26, 2014 02:47:21 PM Lee Jones wrote:
> > ahci: st: Add support for ST's SATA IP
> > 
> > Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index b4a9262..ee7a3dc 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -97,6 +97,15 @@ config SATA_AHCI_PLATFORM
> >  
> >  	  If unsure, say N.
> >  
> > +config SATA_AHCI_ST
> 
> It would be better to name it just ACHI_ST for consistency with
> existing config options (AHCI_IMX and AHCI_SUNXI).

The patch is already in for-3.15 branch.  Lee, can you please post an
incremental patch addressing Bart's review points?

Thanks.

-- 
tejun
