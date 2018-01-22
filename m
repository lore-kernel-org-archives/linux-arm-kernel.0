From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Mon, 22 Jan 2018 12:24:23 +0300
Subject: sun4i drm device tree
In-Reply-To: <20180122085537.2cenqvvpjrbrzf7g@flea.lan>
References: <70275161-0167-fa2e-3557-d15b8244c04d@orpaltech.com>
 <20180122085537.2cenqvvpjrbrzf7g@flea.lan>
Message-ID: <af8c1da9-350e-19d3-a7d7-ed8d8b1dc4cb@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 01/22/2018 11:55 AM, Maxime Ripard wrote:
> Hi,
>
> On Mon, Jan 22, 2018 at 11:15:58AM +0300, Sergey Suloev wrote:
>> as far as I understand it is possible now to compile sun4i-drm for
>> a64 SoC.
> Well, compile yes, but the A64 isn't supported at the moment, so
> compiling it won't get you very far. Where did you get that info from?
I found a patch to enable sun4i-drm compilation for ARM64 and that's 
made me think that. Then I tried to compile it for A64 and it went 
without errors.
>> But it seems that there should be changes to device tree files
>> (arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi,
>> arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi) too.
>>
>> Can you PLEASE give a ref to a patch or explain device tree changes
>> needed?
> And even if it was supported, we'd need a lot more informations to
> help you. For example, which boards, with which video outputs
NanoPi A64, HDMI
> Maxime
>
