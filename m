From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 24 Feb 2014 17:22:27 -0300
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <20140224180336.GU27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
 <20140224180336.GU27282@n2100.arm.linux.org.uk>
Message-ID: <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Feb 24, 2014 at 3:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
>> +     hdmi0: connector at 0 {
>> +             compatible = "hdmi-connector";
>
> This looks way to generic a compatible string.  Are you sure it's
> correct?
>

That compatible string is correct according to the latest series
posted by Tomi Valkeinen to add DT bindings for the OMAP Display
SubSystem (DSS) [0].

The property is added on this patch [1] and as far as I understood the
idea is that it could be a generic DT binding that can be used by
platform specific HDMI connectors like the omap dss HDMI connector
[2].

I'm adding Tomi to the cc list so he can a correct me if I'm wrong.

Thanks a lot and best regards,
Javier

[0]: http://www.spinics.net/lists/linux-omap/msg102522.html
[1]: http://www.spinics.net/lists/linux-omap/msg102559.html
[2]: http://www.spinics.net/lists/arm-kernel/msg302197.html
