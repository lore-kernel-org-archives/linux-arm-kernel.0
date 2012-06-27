From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jun 2012 12:31:01 +0100
Subject: [PATCH V2] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <1340757060-27232-1-git-send-email-swarren@wwwdotorg.org>
References: <1340757060-27232-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120627113100.GF308@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 06:31:00PM -0600, Stephen Warren wrote:

> sm1: HW defaults and schematic match at 1.0v. marvin24's kernel had a max
> of 1.125v, but this wasn't applied since apply_uV wasn't set.

apply_uV is only valid if a single voltage is specified.  If a voltage
range were specified and it were acted on we'd take the lowest (not
highest) voltage allowed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/60890ab1/attachment.sig>
