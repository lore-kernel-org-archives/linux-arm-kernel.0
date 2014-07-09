From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Jul 2014 10:32:02 +0200
Subject: [PATCH 1/3] regulators: tps65218: fix DCDC4 linear voltage range
In-Reply-To: <1404846554-4095-1-git-send-email-balbi@ti.com>
References: <1404846554-4095-1-git-send-email-balbi@ti.com>
Message-ID: <20140709083202.GJ30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 02:09:12PM -0500, Felipe Balbi wrote:
> The second range of this particular regulator,
> starts at 1.60V, not as 1.55V as it was originally
> implied by code.

Applied all, thanks.  Please use subject lines consistent with the style
for the subsystem - these even vary within the series!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/2ecb4acb/attachment.sig>
