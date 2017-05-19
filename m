From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 19 May 2017 15:22:28 +0800
Subject: [linux-sunxi] [PATCH v6 9/9] arm64: allwinner: a64: enable Wi-Fi
 for Pine64
In-Reply-To: <20170519071922.awmib4qphl6ac6mj@flea.home>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-10-icenowy@aosc.io>
 <CAGb2v66mqMveibKKU9LiBm8jzAOj46hFCK6HvJx0k6077fqLZw@mail.gmail.com>
 <79B00D42-3F95-4D5E-9A23-8E893CCF2462@aosc.io>
 <20170519071922.awmib4qphl6ac6mj@flea.home>
Message-ID: <16dee602b96510170ee1117cfaae0025@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-19 15:19?Maxime Ripard ???
> On Fri, May 19, 2017 at 11:03:33AM +0800, Icenowy Zheng wrote:
>> >The patch looks OK, but given the module is removable, I think it
>> >should be
>> >an overlay. The overlay would enable WiFi + Bluetooth, and all the
>> >peripherals needed to connect them.
>> >
>> >That way, if the module is not installed, we avoid confusing the user
>> >with
>> >unused peripherals, and avoid having live voltage on an unoccupied
>> >header.
>> 
>> But as this header have specific usage, we will also confuse user
>> if it's not enabled as its target usage.
> 
> Yet you would enable unused resources.
> 
> This was already pointed out here:
> https://patchwork.kernel.org/patch/9670235/

I think, before we have an official repository of device tree
overlays (either directly in torvalds/linux or maintained by
linux-sunxi), we shouldn't rely on device tree overlay
functionality.

> 
> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
