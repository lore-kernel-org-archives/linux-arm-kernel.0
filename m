From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 19:55:29 +0100
Subject: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support in
 PCI glue layer
In-Reply-To: <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ@mail.gmail.com>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
 <20140725053230.GT1857@lahna.fi.intel.com>
 <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ@mail.gmail.com>
Message-ID: <20140729185529.GG17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 06:13:06PM +0200, Andrea Adami wrote:

> note that a previous version of the patch breaks spi on pxa machines:
> tested on pxa250 poodle and pxa255 corgi.
> The patch is included in linux-Yocto since 3.14.

The interesting question is if this version works...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/46e3c43f/attachment.sig>
