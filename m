From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 20 May 2017 02:08:18 +0800
Subject: [RFC PATCH 07/11] drm: sun4i: add support for the TV encoder in
 H3 SoC
In-Reply-To: <20170519180330.7hpfkdqk3r2x3kn5@flea.home>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-8-icenowy@aosc.io>
 <20170519180330.7hpfkdqk3r2x3kn5@flea.home>
Message-ID: <3FCDBC05-20A1-460C-A21B-8C3E9C776768@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?5?20? GMT+08:00 ??2:03:30, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Thu, May 18, 2017 at 12:43:50AM +0800, Icenowy Zheng wrote:
>> Allwinner H3 features a TV encoder similar to the one in earlier
>SoCs,
>> but with some different points about clocks:
>> - It has a mod clock and a bus clock.
>> - The mod clock must be at a fixed rate to generate signal.
>
>Why?

It's experiment result by Jernej.

The clock rates in BSP kernel is also specially designed
(PLL_DE at 432MHz) in order to be able to feed the TVE.

>
>Maxime
