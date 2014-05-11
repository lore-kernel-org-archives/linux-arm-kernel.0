From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 10 May 2014 23:00:09 -0400
Subject: [TECH TOPIC] ARM legacy board DT conversion finalization
Message-ID: <20140511030009.GO12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Over the past couple of years, the ARM sub-arch maintainers have been
doing a great amount of work migrating to devicetree.

In conjunction with this effort, we've been slowly migrating the
existing legacy platforms (board files) over to devicetree.  For the
small part the mvebu maintainers are responsible for, we can see the
light at the end of the tunnel now. :-)

I imagine several other sub-arches are in a similar situation.  I think
it would be useful for us all to sit down, compare notes, and pool our
resources/experiences to coordinate a final push.

So, I'm proposing a session where each sub-arch gives a brief run-down
of the status of the legacy board conversion, and wraps up with a todo
list.  After all of the sub-arches have given their status (5 - 10
minutes each?), we hash out helping each other with the final pieces.

Also on the agenda, discussing the fate of the legacy sub-arches that
haven't even begun conversion to devicetree.

The intended outcome would be to have a sorted list of remaining
conversions, and who is pitching in to help out for each item.  Also, a
sorted list of unconverted sub-arches, broken down into 'deprecate',
'convert', and 'seek info'.

On a final note, I'd like to include a hobbyist voice or two in here.
Since a lot of the legacy platforms are supported by embedded Debian,
OpenWRT, and similar, getting an idea of which ones we can deprecate
would save quite a bit of work.

I haven't heard word of an ARM mini-summit yet.  If that happens,
obviously this topic would be most appropriate there.

Nominations:

Jason Cooper		(auto-nominated)
Andrew Lunn
Gregory Clement
Sebastian Hesselbarth	(auto-nominated)
Thomas Petazzoni	(auto-nominated)

I can think of several names from the ARM Linux mailinglist, but since I
can't create a conclusive list, I'll leave it up to the individuals to
pipe up if they are interested.

thx,

Jason.
