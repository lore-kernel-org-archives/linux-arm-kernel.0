From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 13 Jan 2016 11:26:13 +0100
Subject: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
In-Reply-To: <20160113084424.GC11560@pali>
References: <20160109230709.GA30551@amd> <5693BB75.70409@ti.com>
 <20160111214247.GA9735@amd> <56942344.9070609@ti.com>
 <56951A2C.9010602@ti.com> <20160112215352.GA5248@amd>
 <20160113084424.GC11560@pali>
Message-ID: <20160113102613.GA28729@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 09:44:24AM +0100, Pali Roh?r wrote:
> On Tuesday 12 January 2016 22:53:52 Pavel Machek wrote:
> > Hi!
> > 
> > > >>If not, tell me, and I can do it, but it will involve a lot of swaring...
> > > >
> > > >I'll give it a look over.
> > > 
> > > OK, I'm still looking for a test setup, but this was definitely a problem,
> > > could you give this a try?:
> > 
> > Well, search no more. I tested it and seems to work ok. There's one
> > more blank line in the source, so I had to apply patch by hand.
> > 
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Reported-by: Pavel Machek <pavel@ucw.cz>
> > Cc: stable at vger.kernel.org
> > 
> > ? :-).
> > 
> > And... thanks!
> > 									Pavel
> 
> There are more pending fixes for bq27xxx... Maybe your is duplicate?

No, it's not a duplicate.

> http://thread.gmane.org/gmane.linux.power-management.general/70090
> http://thread.gmane.org/gmane.linux.power-management.general/69716/focus=69714
> http://thread.gmane.org/gmane.linux.power-management.general/69716/focus=2110580
> 
> Sebastian, please take them and ideally send to stable@ for backporting.

There is no need to send them to stable@, if they are properly
tagged with a 'Fixes: <sha1> ("title")' tag, so please always
include it in your commit messages, if possible :)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160113/b74fb73d/attachment-0001.sig>
