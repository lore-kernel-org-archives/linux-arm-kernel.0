From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Oct 2012 15:18:39 -0600
Subject: [PATCH v2 0/5] ARM: tegra: enable wlan for t20 and t30
In-Reply-To: <1348217700-12309-1-git-send-email-wni@nvidia.com>
References: <1348217700-12309-1-git-send-email-wni@nvidia.com>
Message-ID: <507C7DAF.6020504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2012 02:54 AM, Wei Ni wrote:
> Enable wlan for following tegra board:
> Tegra30: Cardhu.
> Tegra20: Seaboard, Ventana.
> 
> Note that this series depends on specific brcmfmac patches:
> http://thread.gmane.org/gmane.linux.kernel.wireless.general/97337.

Now that those patches are in 3.7-rc1, I've applied this series to
Tegra's for-3.8/wifi branch (first 4) and for-3.8/defconfig branch (last
1). I'm not 100% sure yet exactly which patches will appear for 3.8; I
might just make a single for-3.8/dt branch instead of having a separate
wifi branch; we'll see...

Thanks.
