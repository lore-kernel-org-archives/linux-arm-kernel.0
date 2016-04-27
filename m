From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Apr 2016 23:30:08 +0200
Subject: [PATCH v4 2/4] ARM64: dts: rockchip: add core dtsi file for
 RK3399 SoCs
In-Reply-To: <1461743693-10671-3-git-send-email-jay.xu@rock-chips.com>
References: <1461743693-10671-1-git-send-email-jay.xu@rock-chips.com>
 <1461743693-10671-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <4859199.VscuxbHbWK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. April 2016, 15:54:51 schrieb Jianqun Xu:
> This patch adds core dtsi file for Rockchip RK3399 SoCs.
> 
> The RK3399 has big/little architecture, which needs a separate
> node for the PMU of each microarchitecture, for now it missing
> the pmu node since the old one could not work well.
> 
> Tested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

with some minor reorganizations, applied to my dts64 branch for 4.7


Thanks
Heiko
