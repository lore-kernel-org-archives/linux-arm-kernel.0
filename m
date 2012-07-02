From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 2 Jul 2012 21:26:14 +0200
Subject: 3ad1308 pwm: tegra: Add device tree support
In-Reply-To: <4FF1DC86.1030508@wwwdotorg.org>
References: <4FF1DC86.1030508@wwwdotorg.org>
Message-ID: <20120702192614.GB1299@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 11:38:14AM -0600, Stephen Warren wrote:
> Thierry,
> 
> Could I ask you to apply a small fix to the following commit in your pwm
> for-next tree:
> 
> 3ad1308 pwm: tegra: Add device tree support
> 
> The pwm node is added in the wrong place; the nodes should be sorted
> numerically by address in the reg property, which would put the addition
> between serial and i2c, not between i2c and pmc.

I can do that.

> If you're unable to rebase that branch for some reason, I can send an
> incremental patch to do that.

As mentioned in the other thread, if you carry the two Tegra-specific
patches I can rebase without a problem.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/51ff1d2f/attachment.sig>
