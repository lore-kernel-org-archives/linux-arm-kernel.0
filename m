From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Jan 2016 12:47:28 +0000
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <1453663322-14474-4-git-send-email-mans@mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
Message-ID: <20160127124728.GM6042@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 07:21:50PM +0000, Mans Rullgard wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The source and destination masters are reflecting buses or their layers to
> where the different devices can be connected. The patch changes the master
> names to reflect which one is related to which independently on the transfer
> direction.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/f8d5e2a6/attachment.sig>
