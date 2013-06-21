From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Jun 2013 15:39:54 +0100
Subject: [PATCH v2 2/3] regulator: max8998: Use arrays for specifying
 voltages in platform data
In-Reply-To: <1371818017-5215-3-git-send-email-t.figa@samsung.com>
References: <1371818017-5215-1-git-send-email-t.figa@samsung.com>
 <1371818017-5215-3-git-send-email-t.figa@samsung.com>
Message-ID: <20130621143954.GW27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 02:33:36PM +0200, Tomasz Figa wrote:
> This patch modifies the platform data of max8998 to use arrays for
> specifying predefined voltages of buck1 and buck2 instead of separate
> field for each voltage.
> 
> This allows to simplify the code a bit and will help in adding support
> for Device Tree, which will be introduced in further patch.

This is OK but doesn't apply independently so leaving for now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/19fc3541/attachment.sig>
