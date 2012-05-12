From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 12 May 2012 13:28:52 +0900
Subject: [GIT PULL] Urgent fixes (for v3.4 if possible) for Renesas
 ARM-based platforms
In-Reply-To: <CAOesGMh3g-7oTNBoj2ZWGw+9P1Sf7V89etLb-iZiVoKDEvhO8w@mail.gmail.com>
References: <201205112025.13478.rjw@sisk.pl>
 <CAOesGMh3g-7oTNBoj2ZWGw+9P1Sf7V89etLb-iZiVoKDEvhO8w@mail.gmail.com>
Message-ID: <CANqRtoSDN+vYet+9qiNZQq73BdSiqPL3K+95wCbNL29wDvT4EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

[CC Guennadi]

Thanks for your help!

On Sat, May 12, 2012 at 7:41 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Fri, May 11, 2012 at 11:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Hi,
>>
>> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>>
>> ? ?Linux 3.4-rc6
>>
>> with top-most commit 5fab7b501bf29c08c5b01627b496b6b766bd0165
>>
>> ? ?ARM / mach-shmobile: Invalidate caches when booting secondary cores
>>
>> from the git repository at:
>>
>> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes
>
> No such branch (nor tag).

I believe Rafael will get back to you about that when he gets to his computer.

>> to receive urgent fixes for Renesas ARM-based platforms. ?Four of these commits
>> are fixes of regressions new in 3.4-rc and the last one is necessary for SMP to
>> work on those systems in general.
> [...]
>> Guennadi Liakhovetski (2):
>> ? ? ?ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper
>> ? ? ?ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
>
> These seem to fix the long-standing build errors on the two platforms,
> but that's impossible to tell from reading the commit messages (they
> are empty). Care to add one describing why they're important to go in?

I only know that a) some boards don't build without these fixes and b)
they used to build just fine.

Perhaps Guennadi [CC:ed] could be so kind to fill us in with the blanks?

Thanks,

/ magnus
