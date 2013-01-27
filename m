From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 27 Jan 2013 11:22:59 +0800
Subject: [PATCH] mc13892: sanity check num_regulators parsed vs. registered
In-Reply-To: <1358792745-1737-1-git-send-email-matt@genesi-usa.com>
References: <1358792745-1737-1-git-send-email-matt@genesi-usa.com>
Message-ID: <20130127032249.GG4650@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 12:25:45PM -0600, Matt Sealey wrote:
> Imagine a situation where a device tree has a few regulators in an
> appropriate node:

Applied, thanks.  Always use subject lines appropriate for the
subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130127/6a882d3b/attachment.sig>
