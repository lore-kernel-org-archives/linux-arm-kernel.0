From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jun 2015 13:52:50 -0300
Subject: mx6 hdmi resolution behaviour
In-Reply-To: <20150623164443.GC7557@n2100.arm.linux.org.uk>
References: <CAOMZO5AbC8PCo7J7ovw4izPBK08UkDgKGG++d+9xty4GJ0SzKQ@mail.gmail.com>
 <20150623164443.GC7557@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5BjuOGgqsUNG6K6N-QU1a4oWTdynxsoAECYLeQK_9Kk9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 1:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> If you have no connected connectors, then you get 1024x768:
>
> imx-drm display-subsystem: No connectors reported connected with modes
> [drm] Cannot find any crtc or sizes - going 1024x768
>
> as that's what DRM defaults to when it has no other timing information
> available.

Agreed, but after the cable is connected we could try to find a more
suitable timing?

>> [   16.310548] imx-ipuv3 2400000.ipu: videomode adapted for IPU restrictions
>
> I don't see this message booting on a Hummingboard with HDMI
> disconnected.

I see this message in the following case:

- Boot the board with HDMI disconnected

- Connect the HDMI cable and then such message is displayed.

Thanks
