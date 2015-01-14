From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Jan 2015 19:00:00 +0000
Subject: [PATCH] Asoc: sam9x5_wm8731: depend on ARCH_AT91 instead of
 SOC_AT91SAM9X5
In-Reply-To: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150114190000.GB3043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 01:27:26PM +0100, Alexandre Belloni wrote:
> The SOC_AT91SAM9X5 option is going to be removed, only depend on ARCH_AT91 like
> for the other drivers.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/81beb9e9/attachment.sig>
