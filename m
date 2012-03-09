From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 12:37:04 +0000
Subject: [PATCH v11] Regulator: Add Anatop regulator driver
In-Reply-To: <1331279829-4584-1-git-send-email-paul.liu@linaro.org>
References: <1331279829-4584-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120309123704.GU3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 03:57:09PM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Anatop is an integrated regulator inside i.MX6 SoC.
> There are 3 digital regulators which controls PU, CORE (ARM), and SOC.
> And 3 analog regulators which controls 1P1, 2P5, 3P0 (USB).
> This patch adds the Anatop regulator driver.

This looks good apart from the issue Axel noted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/d7a2a071/attachment-0001.sig>
