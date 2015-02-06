From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Feb 2015 07:53:50 +0800
Subject: [PATCH 2/4] ASoC: samsung: Remove PCM support for WM8580 on SMDK
In-Reply-To: <1421664127.9655.53.camel@x220>
References: <1421664127.9655.53.camel@x220>
Message-ID: <20150206235350.GP31311@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 11:42:07AM +0100, Paul Bolle wrote:
> Commit 28c8331d386a ("ARM: S5PV210: Remove support for board files")
> removed the Kconfig symbols MACH_SMDKC110 and MACH_SMDKV210. As a result
> the dependencies of SND_SOC_SMDK_WM8580_PCM can never be met. So remove
> the unbuildable "SoC PCM Audio support for WM8580 on SMDK".

This doesn't apply against current code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/11482dfd/attachment.sig>
