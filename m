From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Mar 2012 12:38:01 +0000
Subject: [PATCH v13] Regulator: Add Anatop regulator driver
In-Reply-To: <1331692152-9256-1-git-send-email-paul.liu@linaro.org>
References: <1331692152-9256-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120314123800.GH3133@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 10:29:12AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Anatop is an integrated regulator inside i.MX6 SoC.
> There are 3 digital regulators which controls PU, CORE (ARM), and SOC.
> And 3 analog regulators which controls 1P1, 2P5, 3P0 (USB).
> This patch adds the Anatop regulator driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/c7b2514a/attachment.sig>
