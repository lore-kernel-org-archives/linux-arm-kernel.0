From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 02 Aug 2018 14:54:06 +0200
Subject: [PATCH v4 3/4] arm64: dts: rockchip: add io-domain to
 roc-rk3328-cc
In-Reply-To: <1533016762-5268-4-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
 <1533016762-5268-4-git-send-email-djw@t-chip.com.cn>
Message-ID: <3471113.4LqEKgWTCV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 31. Juli 2018, 07:59:21 CEST schrieb djw at t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> It is necessary for the io domain setting of the SoC to match the voltage
> supplied by the regulators.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

applied to my dts64 branch, possibly still for 4.19.
Other dts patches need to wait for the syscon-gpio change to land.

Thanks
Heiko
