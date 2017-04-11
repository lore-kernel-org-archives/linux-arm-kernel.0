From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 21:40:03 +0100
Subject: [PATCH 6/6] regulator: anatop: set default voltage selector for
 pcie
In-Reply-To: <1491962327-12477-6-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170411204003.avoe5a6o52kx5on2@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 09:58:47AM +0800, Dong Aisheng wrote:
> Set the initial voltage selector for vddpcie in case it's disabled
> by default.

Why is this the only anatop regulator which can have this problem and
how do we know this is a good value?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/4f19af2e/attachment.sig>
