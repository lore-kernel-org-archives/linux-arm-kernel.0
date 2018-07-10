From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 10 Jul 2018 15:53:26 +0200
Subject: droid 4: no sound in the morning
In-Reply-To: <20180710105910.GA4442@amd>
References: <20180710105910.GA4442@amd>
Message-ID: <20180710135325.GA23878@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-07-10 12:59:10, Pavel Machek wrote:
> Hi!
> 
> I attempted to use droid 4 as an alarm clock, but got no sound in the
> morning.
> 
> Log said:
> 
> [78798.682830] omap-mcbsp 40124000.mcbsp: CLKS: could not
> clk_set_parent() to prcm_fck
> [78803.561767] omap-mcbsp 40126000.mcbsp: CLKS: could not
> clk_set_parent() to prcm_fck
> 
> Could it be related? Everything ok after reboot, v4.18-rc4.
> 
> Does anyone else see that? Any ideas?

Ok, so I see that

[ 1775.896270] Charging, 4350000 uV, 532000 uA
[ 1778.700286] omap-mcbsp 40124000.mcbsp: CLKS: could not
clk_set_parent() to prcm_fck
[ 1778.898468] Charging, 4350000 uV, 532000 uA

...even when audio still works. So possibly not related.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/2d0cea09/attachment.sig>
