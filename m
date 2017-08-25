From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 25 Aug 2017 11:35:41 +0200
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add cpu regulator for rk3328
 evaluation board
In-Reply-To: <1503542223-21044-4-git-send-email-cl@rock-chips.com>
References: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
 <1503542223-21044-4-git-send-email-cl@rock-chips.com>
Message-ID: <3733498.rByIbfHvAf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. August 2017, 10:37:03 CEST schrieb cl at rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> RK3328 Evaluation Board use rk805 pmic, and one of the DCDCs in
> rk805 is for cpu regulator, assign the cpu regulator, so the
> cpufreq can work fine.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied ... but I cannot say if it will still be eligible for 4.14
(late in the cycle). If necessary I'll move it forward a release.

Thanks
Heiko
