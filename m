From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 18 Jan 2015 23:29:45 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <20150118210217.GB31807@amd>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <10549142.7lWnPtPtZG@wuerfel> <20150113204219.GJ2419@atomide.com>
 <201501132150.56938@pali> <20150118210217.GB31807@amd>
Message-ID: <20150118222944.GA1698@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 10:02:17PM +0100, Pavel Machek wrote:
> > He reported also some (still not fixed) regressions on n900.
> 
> adp1653 flash driver does not have device tree bindings, yet. Patches
> were submitted, but I guess I'll need to push them some more.

Yes, but that's not a regression, since mainline kernel does not
load adp1653 when booted in legacy mode.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150118/7af19704/attachment-0001.sig>
