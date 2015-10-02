From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Oct 2015 11:52:35 +0200
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
Message-ID: <560E53E3.7070207@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ take 1 was sent on 2015-03-26 ]

Hello everyone,

In http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=392348
Stephen Boyd wrote:

> I don't see any problem with the TWD dropping the dependency on SMP.
> The code should work the same on a UP configuration [...]

And Arnd recently said:

> I think this has come up before and should be fixed. Could you
> send a patch that allows using TWD in uniprocessor configurations?

Basically, this means reverting Shawn Guo's 904464b91eca patch.
and removing "depends on SMP" for HAVE_ARM_TWD.

However, Shawn's patch fixed an issue, therefore it seems likely
that simply reverting is not the proper solution?

What should I do?

Regards.
