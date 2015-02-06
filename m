From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Feb 2015 07:55:13 +0800
Subject: [PATCH 1/4] ASoC: samsung: Remove goni or aquila with the WM8994
In-Reply-To: <1421664101.9655.52.camel@x220>
References: <1421664101.9655.52.camel@x220>
Message-ID: <20150206235512.GS31311@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 11:41:41AM +0100, Paul Bolle wrote:
> Commit 28c8331d386a ("ARM: S5PV210: Remove support for board files")
> removed the Kconfig symbols MACH_GONI and MACH_AQUILA. As a result the
> dependencies of SND_SOC_GONI_AQUILA_WM8994 can never be met. So remove
> the unbuildable "SoC I2S Audio support for AQUILA/GONI - WM8994".

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/c6488bb8/attachment.sig>
