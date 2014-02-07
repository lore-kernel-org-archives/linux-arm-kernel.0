From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Feb 2014 12:14:40 +0000
Subject: [PATCH] regulator: core: Allow regulator_set_voltage for fixed
 regulators
In-Reply-To: <1391632226-10060-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1391632226-10060-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140207121440.GY32298@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 12:30:26PM -0800, Bjorn Andersson wrote:
> Make it okay to call regulator_set_voltage on regulators with fixed
> voltage if the requested range overlaps the current/configured voltage.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140207/655ab5f2/attachment-0001.sig>
