From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Sep 2014 18:18:55 -0700
Subject: [PATCH 1/3] regulator: axp20x: Use parent device as regulator
 configuration device
In-Reply-To: <1411243596-15117-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411243596-15117-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140923011855.GA27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 10:06:34PM +0200, Maxime Ripard wrote:
> The current device used for the regulator configuration is the child device
> created by the MFD driver. This means that it doesn't have any of_node pointing
> to it, and whenever we register the regulators, it will not look into the
> regulator supply in the DT, hence requiring to provide regulator aliases in the
> MFD driver.

Applied, thanks.  Please try to wrap your commit message a bit below 80
characters to allow for quoting.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/3d28b96a/attachment.sig>
