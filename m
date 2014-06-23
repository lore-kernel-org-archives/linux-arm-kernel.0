From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Jun 2014 12:31:42 +0200
Subject: [PATCH v2 1/6] wdt: sunxi: Move restart code to the watchdog
 driver
In-Reply-To: <20140522211207.GA28704@roeck-us.net>
References: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399430664-29091-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140507213318.GA2105@roeck-us.net>
 <20140515091123.GQ29258@lukather> <20140519150422.GA27329@lukather>
 <20140522203444.GE27329@lukather>
 <20140522211207.GA28704@roeck-us.net>
Message-ID: <20140623103142.GB19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 02:12:07PM -0700, Guenter Roeck wrote:
> On Thu, May 22, 2014 at 10:34:44PM +0200, Maxime Ripard wrote:
> > On Mon, May 19, 2014 at 05:04:22PM +0200, Maxime Ripard wrote:
> > > On Thu, May 15, 2014 at 11:11:23AM +0200, Maxime Ripard wrote:
> > > > On Wed, May 07, 2014 at 02:33:18PM -0700, Guenter Roeck wrote:
> > > > > On Tue, May 06, 2014 at 09:44:19PM -0500, Maxime Ripard wrote:
> > > > > > Most of the watchdog code is duplicated between the machine restart code and
> > > > > > the watchdog driver. Add the restart hook to the watchdog driver, to be able to
> > > > > > remove it from the machine code eventually.
> > > > > > 
> > > > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > > 
> > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > 
> > > > Wim, do you have any comment on this one?
> > > 
> > > Ping?
> > > 
> > > It would be really great to see this in 3.16, and we get quite close
> > > to the end of ARM's merge window.
> > 
> > Ping?
> > 
> > Guenter, since you seem to be the only responsive, may I suggest that
> > you start merging patches and do a pull request to either Wim or Linus
> > directly during the merge window?
> > 
> I had prepared a pull request for Wim last weekend or so, but then there
> were more patches piling in and I got distracted, so I didn't have time
> to actually send it. I'll try again this weekend ... the kids should be
> busy learning for their finals, and I'll have Friday and Monday off
> from work, so I should be able to find the time.
> 
> As for sending patches to Linus directly, well, Wim is the watchdog maintainer.
> I manage to upset enough people, and would not want to add Wim to the list.
> 
> The patches _are_ in my watchdog-next branch and get some coverage from
> both my auto-builders and from Fenguang's build robots, so while they are
> not in linux-next, they are not completely in the dark either.

So, this patch finally didn't make it into 3.16. Great. Now, we can't
even reboot the boards.

Given how it's just impossible to get something merged reliably
through the watchdog tree, I guess I should just start merging the
patches through mine?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/8b71e6ef/attachment.sig>
