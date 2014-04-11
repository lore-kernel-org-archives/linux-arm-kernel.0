From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Apr 2014 13:23:45 +0100
Subject: [PATCH v4 6/9] regulator: AXP20x: Add support for regulators
 subsystem
In-Reply-To: <1397209093-10077-7-git-send-email-carlo@caione.org>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-7-git-send-email-carlo@caione.org>
Message-ID: <20140411122345.GD28800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 11:38:10AM +0200, Carlo Caione wrote:
> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
> LDOs. This patch introduces basic support for those regulators.

Applied, thanks, but I had to resolve some trivial add/add conflicts
with the Broadcom regulator driver Makefile and Kconfig additions -
please remember to submit patches against current code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/638e3f2c/attachment.sig>
