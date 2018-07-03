From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 03 Jul 2018 20:32:47 +0200
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add pin configurations for
 RK3399
In-Reply-To: <20180628220830.9089-2-ezequiel@collabora.com>
References: <20180628220830.9089-1-ezequiel@collabora.com>
 <20180628220830.9089-2-ezequiel@collabora.com>
Message-ID: <1629911.QSqBjsGapE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 29. Juni 2018, 00:08:29 CEST schrieb Ezequiel Garcia:
> Add pcfg_pull_none_18ma and pcfg_output_low to the
> dtsi file, as they are needed by some boards.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

This looks similar to what Randy wants to do in [0].
As I'll probably apply his patch first, please check if anything is
missing there and if possible base your series on it :-).

Thanks
Heiko

[0] https://patchwork.kernel.org/patch/10479923/
