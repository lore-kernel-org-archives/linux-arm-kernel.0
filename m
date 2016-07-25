From: olof@lixom.net (Olof Johansson)
Date: Sun, 24 Jul 2016 21:30:46 -0700
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v4.8
In-Reply-To: <20160725021552.GJ12825@verge.net.au>
References: <cover.1468808109.git.horms+renesas@verge.net.au>
 <7322553.kXvQYPfzzh@wuerfel> <20160722015924.GH21943@verge.net.au>
 <4175400.eEqji2rNII@wuerfel> <20160725021552.GJ12825@verge.net.au>
Message-ID: <CAOesGMjQN=kM1iwmXYQpQ4-VdnqJbf3FPZhJFB0LjUuh31qfpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resending as non-HTML]

On Sun, Jul 24, 2016 at 7:15 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jul 22, 2016 at 09:30:58PM +0200, Arnd Bergmann wrote:
>> On Friday, July 22, 2016 10:59:24 AM CEST Simon Horman wrote:
>> > On Thu, Jul 21, 2016 at 02:41:52PM +0200, Arnd Bergmann wrote:
>> > > On Monday, July 18, 2016 11:39:35 AM CEST Simon Horman wrote:
>> > > > Renesas ARM Based SoC DT Fixes for v4.8
>> > > >
>> > > > * Corrections to r8a7792
>> > > >
>> > >
>> > > Merged into next/dt, thanks!
>> >
>> > Thanks!
>> >
>> > I have queued up another fix for v4.8 since sending the above to you.
>> > This time it is an SoC (C-code) rather than a DT fix. I am wondering
>> > if you could offer guidance on:
>> >
>> > * If you would prefer me to split fixes out into separate (DT, SoC, ...)
>> >   branches? If so is that until around rc1 when everything has been
>> >   merged into the forthcoming release and thereafter you would prefer
>> >   a single fixes branch?
>>
>> I prefer a separate fixes branch. It's fine for all other branches
>> to be based on top of this branch so you have a working baseline
>> for testing.
>
> Is some sort of minimal base for the fixes branch desired?
> If should the base be a merge of all the tags you have pulled for v4.8?
>
> Currently I have DT fixes and SoC fixes which depend on
> respective tags that have been accepted for v4.8.


It's hard to make those one branch without doing your own merge. You
can't take a merge out of our for-next branch as a base, since those
aren't stable.

Wait for our merges to go into Linus' tree, then use his last merge
commit as the base (before -rc1 is out).


-Olof
