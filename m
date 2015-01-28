From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:52:25 +0000
Subject: [PATCH 1/9] regulator: core: Consolidate drms update handling
In-Reply-To: <1422413199-17273-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422413199-17273-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20150128195225.GO21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:46:31PM -0800, Bjorn Andersson wrote:
> Refactor drms_uA_update() slightly to allow regulator_set_optimum_mode()
> to utilize the same logic instead of duplicating it.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/86e656d8/attachment.sig>
