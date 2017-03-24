From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Mar 2017 12:55:06 +0000
Subject: [RFC 6/8] regulator: core: Add regulator_is_bypass function
In-Reply-To: <e74c2f4d2b452cbe01aa2a48edde5c024212ffcb.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <e74c2f4d2b452cbe01aa2a48edde5c024212ffcb.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <20170324125506.5cxiykpq2tzzkltb@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 06:53:08PM +0200, Leonard Crestez wrote:

>  /**
> + * regulator_is_bypass - Determine if the regulator is in bypass mode

Bypass is a verb so this should be regulator_is_bypassed()
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170324/159ccc5b/attachment.sig>
