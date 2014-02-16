From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 16 Feb 2014 23:03:11 +0100
Subject: [PATCH v4 0/2] usb: musb dsps updates
In-Reply-To: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140216220311.GB31006@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 17, 2014 at 10:22:34AM +0100, Markus Pargmann wrote:
> Hi,
> 
> The two remaining patches from the previous series "usb: musb bugfixes". In v4
> I used the device name for the debugfs root dir and added a commit message to
> the second patch.

Felipe, could you please have a look at this?

Thanks,

Markus

> 
> Regards,
> 
> Markus
> 
> 
> Markus Pargmann (2):
>   usb: musb: dsps, debugfs files
>   usb: musb: dsps, use devm_kzalloc
> 
>  drivers/usb/musb/musb_dsps.c | 58 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 3 deletions(-)
> 
> -- 
> 1.8.5.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
