From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 10:57:20 +0000
Subject: [PATCH v12] Regulator: Add Anatop regulator driver
In-Reply-To: <1331349188-14765-1-git-send-email-paul.liu@linaro.org>
References: <1331349188-14765-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120312105719.GD3110@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2012 at 11:13:08AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Anatop is an integrated regulator inside i.MX6 SoC.
> There are 3 digital regulators which controls PU, CORE (ARM), and SOC.
> And 3 analog regulators which controls 1P1, 2P5, 3P0 (USB).
> This patch adds the Anatop regulator driver.

This looks OK but doesn't apply against current regulator code due to
sorting in Kconfig and Makefile, you should always submit against
current development versions of the subsystem.  Please rebase and
resend, this will also give you an opportunity to build test against the
current subsystem :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/825e44f1/attachment-0001.sig>
