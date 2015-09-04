From: dawei.chien@mediatek.com (dawei chien)
Date: Fri, 4 Sep 2015 18:00:37 +0800
Subject: thermal: mediatek: Add cpu power cooling model
In-Reply-To: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1441360837.18285.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, forgot to add Rafael and Viresh as reviewer.

On Fri, 2015-09-04 at 17:01 +0800, Dawei Chien wrote:
> Use Intelligent Power Allocation (IPA) technical to add
> static/dynamic power model for binding CPU thermal zone.
> The power allocator governor allocates power budget to control
> CPU temperature.
> 
> Dawei.Chien (2):
>   thermal: mediatek: Add cpu power cooling model.
>   arm64: dts: mt8173: Add thermal zone node for mt8173.
> 
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++
>  drivers/cpufreq/mt8173-cpufreq.c         |   97 ++++++++++++++++++++++++++----
>  2 files changed, 130 insertions(+), 11 deletions(-)
> 
> --
> 1.7.9.5
> 
