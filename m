From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Nov 2014 22:14:21 +0800
Subject: [PATCH 0/3] ARM: dts: vf610: USB/GPIO fixes
In-Reply-To: <1415106430-6271-1-git-send-email-stefan@agner.ch>
References: <1415106430-6271-1-git-send-email-stefan@agner.ch>
Message-ID: <20141111141419.GC2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 02:07:07PM +0100, Stefan Agner wrote:
> Hi Shawn,
> 
> This patchset collects some vf610 device tree fixes. The first patch
> was part of the "vf610: Add GPIO support" patchset. GPIO support is
> merged by know, so I rebased that on top of your for-next branch.
> 
> The second patch is a USB fix I uncovered while testing the 3rd patch,
> which adds regulators, mainly for proper USB VBUS support, as we have
> them on our carrier boards.
> 
> Stefan Agner (3):
>   ARM: dts: vf610: use new GPIO support
>   ARM: dts: vf610: enable USB misc/phy nodes where necessary

Applied the first two, thanks.

Shawn

>   ARM: dts: vf-colibri: add USB regulators
> 
>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 45 ++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/vf-colibri.dtsi         | 37 +++++++++++++++++++++++++
>  arch/arm/boot/dts/vf610-twr.dts           |  9 +++++++
>  arch/arm/boot/dts/vfxxx.dtsi              |  1 +
>  4 files changed, 91 insertions(+), 1 deletion(-)
> 
> -- 
> 2.1.3
> 
