From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Mar 2014 18:38:50 +0000
Subject: [PATCH v2 2/7] sound: ASoC: add S/PDIF support to Armada 370 DB
 ASoC driver
In-Reply-To: <1392225662-20431-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392225662-20431-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140318183850.GN11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 06:20:57PM +0100, Thomas Petazzoni wrote:
> The Armada 370 DB board not only has analog audio input/output, but
> also S/PDIF input/output. This commit adds support for S/PDIF in the
> ASoC machine driver of the Armada 370 DB platform, and adjusts the
> Device Tree bindings documentation accordingly.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/406665a1/attachment.sig>
