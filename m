From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Jun 2012 23:54:17 +0100
Subject: [V3 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <1340278283-16423-1-git-send-email-jtzhou@marvell.com>
References: <20120621101536.GR4037@opensource.wolfsonmicro.com>
 <1340278283-16423-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120621225417.GC4037@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 07:31:23PM +0800, Jett.Zhou wrote:
> Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
> it needs to be enabled for charging battery, and will be disabled in
> some exception condition like over-temp.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though it seems really sad that we're not able to structure things so
that an additon like this doesn't need to have explict code in the MFD
as part of the same commit.  If there's no build dependency on anything
in the rest of the series I can apply via the regulator tree?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120621/0d50a170/attachment.sig>
