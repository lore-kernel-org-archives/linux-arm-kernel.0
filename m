From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Mar 2015 20:05:50 +0000
Subject: [PATCH v5 07/12] regulator: axp20x: add support for AXP22X
 regulators
In-Reply-To: <1425988764-23618-8-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-8-git-send-email-wens@csie.org>
Message-ID: <20150310200550.GI28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:59:18PM +0800, Chen-Yu Tsai wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> Add AXP22X regulator definitions and variant id associations.
> This introduces a new "switch" type output for one of the regulators.
> It is a switchable secondary output of one regulator, with the same
> voltage level as the primary output.

Wait, no - sorry.  I'd missed the defines being added earlier on.
Instead:

Reviewed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/8e72c973/attachment-0001.sig>
