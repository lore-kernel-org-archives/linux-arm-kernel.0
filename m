From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Jul 2014 15:45:52 +0200
Subject: [PATCH v2 00/14] AT91: PIT: Cleanups and move to
 drivers/clocksource
In-Reply-To: <53C7A61C.7030704@linaro.org>
References: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140710075105.GA27469@lukather> <20140717095020.GB20328@lukather>
 <53C7A61C.7030704@linaro.org>
Message-ID: <20140717134552.GE20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:31:56PM +0200, Daniel Lezcano wrote:
> On 07/17/2014 11:50 AM, Maxime Ripard wrote:
> >On Thu, Jul 10, 2014 at 09:51:05AM +0200, Maxime Ripard wrote:
> >>Hi Daniel,
> >>
> >>On Tue, Jul 01, 2014 at 11:33:13AM +0200, Maxime Ripard wrote:
> >>>Hi everyone,
> >>>
> >>>This series cleans up the PIT driver in order for it to not depend on
> >>>anything in mach-at91 anymore, and in the end move it out of
> >>>mach-at91.
> >>>
> >>>Along the way, these patches also do a bit of cleanup.
> >>>
> >>>This has been tested on a G45-EK without DT and an Xplained with DT.
> >>>
> >>
> >>Even though most of this patches are not clocksource related, it would
> >>be great if we could at least get an acked-by on the last patch that
> >>moves the driver to drivers/clocksource, since it pretty much becomes
> >>your burden :)
> >
> >Ping?
> 
> Hi,
> 
> I am in vacation right now. I will review the patches in the next two days.

Oh sorry then, enjoy your vacations :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/ebaabd91/attachment-0001.sig>
