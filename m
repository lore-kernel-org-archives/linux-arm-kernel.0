From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Mar 2015 20:05:57 +0000
Subject: [PATCH v5 06/12] regulator: axp20x: prepare support for multiple
 AXP chip families
In-Reply-To: <1425988764-23618-7-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-7-git-send-email-wens@csie.org>
Message-ID: <20150310200557.GJ28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:59:17PM +0800, Chen-Yu Tsai wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> Rework the AXP20X_ macros and probe function to support the several chip
> families, so that each family can define it's own set of regulators.

Wait, no - sorry.  I'd missed the defines being added earlier on.
Instead:

Reviewed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/fc128817/attachment-0001.sig>
