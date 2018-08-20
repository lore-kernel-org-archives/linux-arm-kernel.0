From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 20 Aug 2018 19:53:58 +0800
Subject: [PATCH] drm: sun4i: exclusively set HDMI-related clocks for
 dw-hdmi
In-Reply-To: <20180820115244.x5z6lm4i7tpqptgs@flea>
References: <20180815120745.36593-1-icenowy@aosc.io>
 <20180820115244.x5z6lm4i7tpqptgs@flea>
Message-ID: <DA70F8EF-E64D-4295-A4A5-9F8EB616BB71@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?8?20? GMT+08:00 ??7:52:44, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>Hi!
>
>On Wed, Aug 15, 2018 at 08:07:45PM +0800, Icenowy Zheng wrote:
>> The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
>> dw-hdmi exclusively, which will lead the display fails to initialize
>in
>> some situations.
>
>Apart from the feedback already given, detailing which situations
>would be very helpful.

This patched is rewritten now, and new version will come
after -rc1.

>
>Maxime
