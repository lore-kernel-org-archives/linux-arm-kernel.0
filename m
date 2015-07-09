From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 09 Jul 2015 15:26:40 -0700
Subject: [GIT PULL] Allwinner late changes for 4.2
In-Reply-To: <20150709120458.GX28632@lukather> (Maxime Ripard's message of
 "Thu, 9 Jul 2015 14:04:58 +0200")
References: <20150705203429.GA21927@lukather>
 <7hk2uacp7i.fsf@deeprootsystems.com> <20150709120458.GX28632@lukather>
Message-ID: <7hmvz5arxb.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Hi Kevin,
>
> On Wed, Jul 08, 2015 at 02:30:09PM -0700, Kevin Hilman wrote:
>> Maxime Ripard <maxime.ripard@free-electrons.com> writes:
>> 
>> > Hi Arnd, Kevin, Olof,
>> >
>> > Here is a bunch of late patches (because I forgot about them) for the
>> > 4.2 merge window.
>> >
>> > They're not really controversial, are fixing some issues for the A33
>> > and H3 not having the reset controller initialised soon enough (by
>> > adding their compatible to the already existing DT machine), and the
>> > clock protection code not being run, resulting in the CPU (mainly)
>> > clock being shut down at the end of the boot.
>> >
>> > They've also been in linux-next for quite some time, so I don't expect
>> > any breakage from them.
>> 
>> Hmm, this is just a tad bit late. ;) Even several days after we sent
>> our own "late" branch to Linus.  I'm afraid this is going to miss
>> v4.2.
>
> Hmmm, I thought you said you wanted them before -rc1 was out?
>
>> If there are real fixes in here, feel free to send as separate
>> patches and I'll queue them for v4.2-rc.
>
> Yes, the two patches in mach-sunxi are needed, otherwise the boards
> using this platform won't even boot. I'll submit them in a separate PR
> then.

Nevermind, you're right.  I had forgotten we has already discussed
this.  Thanks for the reminder.

I guess I'm purging my my brain a little early in preparation to
take some time off (the next 2 weeks.)

I've pulled this into fixes, and added to for-next.  Should get a PR of
our fixes branch out to Linus tomorrow, after a spin through
kernelci.org.

Thanks,

Kevin
