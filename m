From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Jun 2016 14:28:01 +0200
Subject: [PATCH RESEND V2] ARM64: config: Enable MAX77620
 pinctrl/gpio/rtc for Tegra210 P2180
In-Reply-To: <1466143556-31849-1-git-send-email-ldewangan@nvidia.com>
References: <1466143556-31849-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160623122801.GA30196@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 11:35:56AM +0530, Laxman Dewangan wrote:
> NVIDIA's Tegra210 Jetson platform (P2180) uses the MAX77620 as PMIC.
> Enable GPIO, Pincontrol and RTC driver for this device.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - MFD and regulator is already enabled, enabling remaining driver.
> 
> Resending to linux-tegra group also.
> 
> 
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Squashed this into the defconfig update patch for v4.8.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/035c7365/attachment.sig>
