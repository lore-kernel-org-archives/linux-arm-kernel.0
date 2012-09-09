From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Sep 2012 17:52:27 -0700
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <20120908215609.GH13739@n2100.arm.linux.org.uk>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209060904.14903.arnd@arndb.de> <20120906094703.GA7308@glitch>
 <201209061546.45242.arnd@arndb.de>
 <20120908215609.GH13739@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMi3Bht42ooGx3Es3DN5khO9f+J38kXK4+wDyRjbvQBUeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2012 at 2:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 06, 2012 at 03:46:44PM +0000, Arnd Bergmann wrote:
>> We just had a discussion about
>> stale platforms at the ARM mini summit in San Diego. IMHO if a port
>> gets started and then nobody works on filling the gaps for two
>> years, we should remove it again.
>
> One of the issues there is that you don't know if the reason it's not
> receiving patches or comments is because it works and people are using
> it, and they don't have anything to report against it.
>
> That's certainly true of a number of platforms we currently have.

No one is interested in removing a platform that is used, but it has
been somewhat discouraging when there have been long-standing build
breakages even on defconfigs for some of them. Without rattling the
cage a bit, it's hard to find out if anyone actually cares about them
enough to build and boot an upstream kernel at least every release or
so.

And yes, in some cases they definitely do. Just see ks8695 as of the
last week -- we've even got someone stepping up to take on
maintainership (thanks Greg!).

-Olof
