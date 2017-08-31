From: codekipper@gmail.com (Code Kipper)
Date: Thu, 31 Aug 2017 18:35:43 +0200
Subject: [linux-sunxi] Re: [PATCH 3/3] dmaengine: sun6i: Add support for
 Allwinner A64
In-Reply-To: <20170831145246.p4k3uakbn67na3pv@flea.lan>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
 <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
 <20170831145246.p4k3uakbn67na3pv@flea.lan>
Message-ID: <CAEKpxBkKAVV0wnQq7YD8MpPM31DGindVgHDstTc082HiUSSd=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 August 2017 at 16:52, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Aug 31, 2017 at 01:36:09AM +0200, Stefan Br?ns wrote:
>> The A64 SoC has the same dma engine as the H3 (sun8i), with a
>> reduced amount of physical channels. Add the proper config data
>> and compatible string to support it.
>>
>> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++++
>>  drivers/dma/sun6i-dma.c                       | 7 +++++++
>>  2 files changed, 11 insertions(+)
>
> With what device did you test this? As far as I know, the SPI driver
> doesn't use DMA at all.
>
Hi Maxime,
I've tested this on spdif and i2s on the Pine64.
BR,
CK
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
