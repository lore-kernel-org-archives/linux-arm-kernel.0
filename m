From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 10 Sep 2016 23:51:36 +0200
Subject: [PATCH 0/8] ARM: dts: rockchip: Remove skeleton.dtsi usage and
 fix memory node DTC warnings
In-Reply-To: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
References: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
Message-ID: <3454871.4xYDbdxxdl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Am Freitag, 9. September 2016, 10:01:01 CEST schrieb Javier Martinez Canillas:
> This series removes the inclusion of the skeleton.dtsi in all the Rockchip
> dts, which allows to get rid of the DTC warnings about a mismatch between
> the memory nodes' unit names and reg properties.
> 
> Patches are pretty trivial and shouldn't cause functional changes AFAIK,
> but were only built tested and dtbs compared with scripts/dtc/dtx_diff.

applied all 8 to my dts branch (for 4.9 but might get delayed to 4.10 ... not 
sure yet)


Thanks
Heiko
