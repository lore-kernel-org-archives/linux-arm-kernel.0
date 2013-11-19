From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 10:16:05 +0000
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131119091140.GE31504@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
 <20131118135727.GD14306@sirena.org.uk>
 <20131118152920.GL26046@ulmo.nvidia.com>
 <20131118155022.GB28334@sirena.org.uk>
 <20131118160626.GN26046@ulmo.nvidia.com>
 <20131118183502.GP2674@sirena.org.uk>
 <20131119091140.GE31504@ulmo.nvidia.com>
Message-ID: <20131119101605.GX2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 10:11:42AM +0100, Thierry Reding wrote:

> Isn't that the reason why PSCI and similar have been conceived? Even DT
> is a byproduct of those developments. What we've been doing so far is to

Right, but notice that PSCI is getting introduce along with ARMv8 -
nobody is deploying it on ARMv7 and below.  The new CPU architecture
gave a pressing reason to switch and ate the cost of doing so.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/532b57e6/attachment.sig>
