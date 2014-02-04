From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 18:22:20 +0000
Subject: Extending OPP bindings
In-Reply-To: <52F12AE7.904@ti.com>
References: <52EA570A.8040501@arm.com> <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
 <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com>
 <20140131180929.GH2616@e102568-lin.cambridge.arm.com>
 <52F12AE7.904@ti.com>
Message-ID: <20140204182220.GQ22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 12:01:11PM -0600, Nishanth Menon wrote:

> As long as the key to the data sets are all the same (frequency),
> information in data set #0 is maintained. It would be in our common
> long term interest to maintain the split.

You're assuming that the frequency is a unique key here.  That may not
be the case, for example two OPPs might have the same CPU clock
(assuming that's the frequency you're referring to) but different bus
clocking and of course the CPUs or CPU clusters might be individually
scalable (this is common in big.LITTLE designs I think).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/8dd2600f/attachment.sig>
