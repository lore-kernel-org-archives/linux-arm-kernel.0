From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 29 Nov 2012 14:02:45 +0100 (CET)
Subject: [PATCH] ARM: mx25_3ds: Add camera support
In-Reply-To: <CAOMZO5C0RSYfMWY1qHmuVJ00+48hvZQJrKcAom_0AE9qYmxOHA@mail.gmail.com>
References: <1354022509-20505-1-git-send-email-fabio.estevam@freescale.com>
 <20121128060543.GA31335@sapphire.tkos.co.il>
 <CAOMZO5C0RSYfMWY1qHmuVJ00+48hvZQJrKcAom_0AE9qYmxOHA@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1211291402260.11210@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Nov 2012, Fabio Estevam wrote:

> Hi Baruch,
> 
> On Wed, Nov 28, 2012 at 4:05 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> 
> > Good to see some activity on i.MX25 camera support. Did you test video capture
> > with a latest kernel?  You have surely noticed that i.MX25 support in the
> > mx2_camera driver is marked BROKEN since 087c78a8.
> 
> I basically checked that mx2_camera can be probed:
> 
> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx2-camera imx25-camera.0: Camera driver attached to camera 0
> ov2640 0-0030: ov2640 Product ID 26:42 Manufacturer ID 7f:a2
> i2c i2c-0: OV2640 Probed
> mx2-camera imx25-camera.0: Camera driver detached from camera 0
> mx2-camera imx25-camera.0: MX2 Camera (CSI) driver probed, clock
> frequency: 22166666
> 
> Tried a Gstreamer pipeline but it is failing, but this Gstreamer issue
> is not mx25 related as I saw the same issue with mx27/mx31.

Can you try mplayer?

Thanks
Guennadi

> Do you still have access to a mx25pdk?
> 
> I will try v4l-utils when I get a chance.
> 
> Regards,
> 
> Fabio Estevam
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
