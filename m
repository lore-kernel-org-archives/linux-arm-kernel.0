From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 May 2014 11:11:23 +0200
Subject: [PATCH v2 1/6] wdt: sunxi: Move restart code to the watchdog
 driver
In-Reply-To: <20140507213318.GA2105@roeck-us.net>
References: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399430664-29091-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140507213318.GA2105@roeck-us.net>
Message-ID: <20140515091123.GQ29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 02:33:18PM -0700, Guenter Roeck wrote:
> On Tue, May 06, 2014 at 09:44:19PM -0500, Maxime Ripard wrote:
> > Most of the watchdog code is duplicated between the machine restart code and
> > the watchdog driver. Add the restart hook to the watchdog driver, to be able to
> > remove it from the machine code eventually.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Wim, do you have any comment on this one?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/9b5481c6/attachment.sig>
