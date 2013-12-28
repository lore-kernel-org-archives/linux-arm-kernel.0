From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 27 Dec 2013 17:13:04 -0800
Subject: [PATCH v2 2/5] input: sun4i-ts: Add support for temperature sensor
In-Reply-To: <1388156399-29677-3-git-send-email-hdegoede@redhat.com>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
 <1388156399-29677-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20131228011304.GB14188@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
>  
> +Optional properties:
> + - ts-attached: boolean set this to tell the driver that an actual touchscreen
> +		is attached and that it should register an input device,
> +		without this it only registers the builtin temperate sensor

I believe the guidance is to avoid describing kernel behavior in DT
property so I think it should say:

 - ts-attached: boolean indicating that an actual touchscreen is
		attached to the controller.

Thanks.

-- 
Dmitry
