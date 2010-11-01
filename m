From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Mon, 01 Nov 2010 16:15:30 +0200
Subject: [PATCH 0/2] OMAP: DSS2: Add new display panel
In-Reply-To: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
References: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
Message-ID: <1288620930.5614.16.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2010-10-28 at 16:43 +0200, ext Enric Balletbo i Serra wrote:
> Hi,
> 
> Next patches adds support for the two new LCD panel display used
> on IGEP boards.
> 
>  Powertip PH480272T LCD 4.3inch (480x242) display
>  Seiko 70WVW1TZ3 LCD 7.0inch WVGA (800x480) display
> 
> Please, consider adding in next merge window.
> 
> Cheers,
> 
> Enric Balletbo i Serra (2):
>   OMAP: DSS2: Add Powertip PH480272T display panel
>   OMAP: DSS2: Add Seiko 70WVW1TZ3 display panel

These both are "dummy" panels, and the driver is basically a copy of the
existing drivers. I don't think I will merge any more of these, sorry.

What we need is a common driver for all these dummy panels, and the
driver would contain configurations for all the supported panels. The
board file would pass the name of the panel used in that board to the
driver, and the driver would use the configurations for that panel.

This has been discussed a few times in l-o list, but I haven't found
time to implement it and nobody else has done it either.

 Tomi
