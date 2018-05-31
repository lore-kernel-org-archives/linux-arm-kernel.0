From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 May 2018 11:38:23 +0100
Subject: [PATCH v4 0/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <da40510b-443d-d8fd-7285-c6e7eff45dc6@codeaurora.org>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <20180530163343.GV6920@sirena.org.uk>
 <da40510b-443d-d8fd-7285-c6e7eff45dc6@codeaurora.org>
Message-ID: <20180531103823.GB13319@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 05:11:54PM -0700, David Collins wrote:

> I'll split up the patches so that reviewing is easier.  For the base
> patch, would you prefer that I remove *all* mode support (handled by
> generic regulator framework DT properties) or only remove the special
> purpose drms mode handling support (i.e. qcom,regulator-drms-modes and
> qcom,drms-mode-max-microamps)?

Standard operations should be fine, just weird custom stuff that's been
causing issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180531/cc95ff7c/attachment.sig>
