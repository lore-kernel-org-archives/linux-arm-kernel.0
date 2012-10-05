From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 5 Oct 2012 04:43:56 +0000
Subject: [PATCH v2 0/7] uio_pruss cleanup and platform support
In-Reply-To: <20121003150058.GB11180@beef>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
 <20121003150058.GB11180@beef>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA9C6B7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On Wed, Oct 03, 2012 at 20:30:58, Porter, Matt wrote:
> On Fri, Sep 28, 2012 at 03:37:45PM -0400, Matt Porter wrote:
> > Changes since v1:
> > 	- Replaced uio_pruss private SRAM API use with genalloc
> > 	- Added DA850 platform device and clock support
> > 	- Added DA850 L3 RAM gen_pool support
> > 	- Split out DT binding
> > 
> > This series enables uio_pruss on both DA850 and AM33xx. The driver
> > previously was not enabled by any platform and the private SRAM API
> > was accessing an invalid SRAM bank for use on DA850. For AM33xx,
> > DT, pinctrl, and runtime PM support are added since AM33xx only
> > boots via DT.
> 
> I'm dropping AM33xx/OMAP support from v3 for this series 

Just for my clarification, I believe you will be taking up AM33xx/OMAP 
SRAM support later once you have completed supporting DaVinci. Right?

> since the
> focus has turned to fixing Davinci SRAM to provide genalloc support
> and the associated use of that in the driver.
> 
> I'll have a separate series with AM33xx support since dealing cleanly
> with external resets on OMAP is a bigger issue.
> 
> -Matt
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 


Regards, 
Gururaja
