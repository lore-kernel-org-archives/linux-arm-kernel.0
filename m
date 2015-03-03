From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Mar 2015 09:44:06 +0000
Subject: [PATCH] [RFC] ARM: shmobile: R-Car Gen2: Add da9063/da9210
 regulator quirk
In-Reply-To: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
References: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150303094406.GI21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 06:28:43PM +0100, Geert Uytterhoeven wrote:
> The r8a7791/koelsch development board has da9063 and da9210 regulators.
> Both regulators have their interrupt request lines tied to the same
> interrupt pin (IRQ2) on the SoC.

Reviewed-by: Mark Brown <broonie@kernel.org>

This is all rather fun isn't it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150303/3c87650d/attachment.sig>
