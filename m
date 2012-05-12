From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 May 2012 22:55:40 -0700
Subject: [GIT PULL] Urgent fixes (for v3.4 if possible) for Renesas
 ARM-based platforms
In-Reply-To: <CANqRtoSDN+vYet+9qiNZQq73BdSiqPL3K+95wCbNL29wDvT4EA@mail.gmail.com>
References: <201205112025.13478.rjw@sisk.pl>
 <CAOesGMh3g-7oTNBoj2ZWGw+9P1Sf7V89etLb-iZiVoKDEvhO8w@mail.gmail.com>
 <CANqRtoSDN+vYet+9qiNZQq73BdSiqPL3K+95wCbNL29wDvT4EA@mail.gmail.com>
Message-ID: <CAOesGMieNxya9w=2a0Lv06qbVb2SOtiLTYeWW=kQ9sbkSzbtvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Magnus,

On Fri, May 11, 2012 at 9:28 PM, Magnus Damm <magnus.damm@gmail.com> wrote:

>>> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes
>>
>> No such branch (nor tag).
>
> I believe Rafael will get back to you about that when he gets to his computer.

Yep, good.

>>> Guennadi Liakhovetski (2):
>>> ? ? ?ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper
>>> ? ? ?ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
>>
>> These seem to fix the long-standing build errors on the two platforms,
>> but that's impossible to tell from reading the commit messages (they
>> are empty). Care to add one describing why they're important to go in?
>
> I only know that a) some boards don't build without these fixes and b)
> they used to build just fine.
>
> Perhaps Guennadi [CC:ed] could be so kind to fill us in with the blanks?

It was pretty obvious once I tried applying them and building that
they did indeed resolve the build errors. However, the reason I'm
asking for a better description is that when looking at just the pull
request, or even the patch full commit description, it was impossible
to tell why the patch was urgent as a fix. So, while I am not
questioning that the patch should be included, I'm just requesting to
make sure it's properly described. That's also good for historical
purposes when someone is reading the git logs a year from now, etc.


-Olof
