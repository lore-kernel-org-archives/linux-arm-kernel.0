From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 May 2014 17:04:22 +0200
Subject: [PATCH v2 1/6] wdt: sunxi: Move restart code to the watchdog
 driver
In-Reply-To: <20140515091123.GQ29258@lukather>
References: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399430664-29091-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140507213318.GA2105@roeck-us.net>
 <20140515091123.GQ29258@lukather>
Message-ID: <20140519150422.GA27329@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:11:23AM +0200, Maxime Ripard wrote:
> On Wed, May 07, 2014 at 02:33:18PM -0700, Guenter Roeck wrote:
> > On Tue, May 06, 2014 at 09:44:19PM -0500, Maxime Ripard wrote:
> > > Most of the watchdog code is duplicated between the machine restart code and
> > > the watchdog driver. Add the restart hook to the watchdog driver, to be able to
> > > remove it from the machine code eventually.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Wim, do you have any comment on this one?

Ping?

It would be really great to see this in 3.16, and we get quite close
to the end of ARM's merge window.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/ab19d5ae/attachment.sig>
