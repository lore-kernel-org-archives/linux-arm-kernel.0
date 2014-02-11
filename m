From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Feb 2014 12:38:24 +0000
Subject: [PATCH 2/7] sound: soc: enable Kirkwood driver for mvebu platforms
In-Reply-To: <1391102051-5319-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1391102051-5319-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140211123824.GN13533@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 06:14:06PM +0100, Thomas Petazzoni wrote:
> The audio unit found in the Armada 370 SoC is similar to the one used
> in the Marvell Kirkwood and Marvell Dove SoCs. Therefore, this commit
> allows the Kirkwood audio driver to be built on mvebu platforms, and
> adds an additional compatible string to identify the Armada 370
> variant of the audio unit.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/b5f905d4/attachment.sig>
