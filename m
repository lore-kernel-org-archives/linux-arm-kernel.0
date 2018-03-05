From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Mar 2018 12:24:29 +0000
Subject: [PATCH v7 10/13] arm64: topology: rename cluster_id
In-Reply-To: <20180228220619.6992-11-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-11-jeremy.linton@arm.com>
Message-ID: <20180305122429.GA25758@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 04:06:16PM -0600, Jeremy Linton wrote:

> Lets match the name of the arm64 topology field
> to the kernel macro that uses it.

I called it cluster ID in the code because that's what the documentation
for MPIDR called it IIRC.  Googling around suggests that this naming may
be being used by some of the DynamiQ stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/29609d32/attachment.sig>
