From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Jun 2013 15:54:29 +0100
Subject: [PATCH v3 2/3] regulator: max8998: Use arrays for specifying
 voltages in platform data
In-Reply-To: <1372077594-17052-3-git-send-email-t.figa@samsung.com>
References: <1372077594-17052-1-git-send-email-t.figa@samsung.com>
 <1372077594-17052-3-git-send-email-t.figa@samsung.com>
Message-ID: <20130624145429.GP27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 02:39:53PM +0200, Tomasz Figa wrote:
> This patch modifies the platform data of max8998 to use arrays for
> specifying predefined voltages of buck1 and buck2 instead of separate
> field for each voltage.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/f0d2b972/attachment-0001.sig>
