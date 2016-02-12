From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Feb 2016 20:03:11 +0000
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <2686474.cvCA6vY47l@wuerfel>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
 <2686474.cvCA6vY47l@wuerfel>
Message-ID: <20160212200311.GB11402@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 08:48:58PM +0100, Arnd Bergmann wrote:

> which all look like they are regmap_mmio users as well. Do they 
> suffer from the same problem?

Probably, yes.  It's only a problem if they're in systems that might
otherwise run big endian successfully.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/46c8c533/attachment.sig>
