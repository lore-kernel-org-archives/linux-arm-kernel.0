From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Jan 2017 12:37:46 +0000
Subject: [PATCH] regulator: constify regulator_ops structures
In-Reply-To: <1485427668-2816-1-git-send-email-bhumirks@gmail.com>
References: <1485427668-2816-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170126123746.r5rzt6tcvktei4ti@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 04:17:48PM +0530, Bhumika Goyal wrote:
> Declare regulator_ops structures as const as they are only stored in the
> ops field of a regulator_desc structure. This field is of type const, so
> regulator_ops structures having this property can be made const too.

Please split this up into a series of per driver changes, it'll be much
easier to both review and apply.  Right now the patch is very big and as
the 0day bot found it's going to be very prone to conflicts.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/fc86f8e9/attachment.sig>
