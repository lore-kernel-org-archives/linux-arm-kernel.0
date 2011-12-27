From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 14:22:31 -0800
Subject: [GIT PULL 1/5] Tegra cleanups for 3.3
In-Reply-To: <201112272219.38986.arnd@arndb.de>
References: <CAOesGMja7+nA-VSF9bEmUJRbpLbVwZ+ngC1+qJ4Sz8L3Bx0m5A@mail.gmail.com>
 <201112272219.38986.arnd@arndb.de>
Message-ID: <CAOesGMi7-wTTBBXEWhhB6XvJBynS0YpR+WpsNKYTAjhRkku1BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 2:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 21 December 2011, Olof Johansson wrote:
>> Hi Arnd,
>>
>> Please pull the following cleanups for tegra. Thanks!
>>
>>
>> The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
>>
>> ? Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)
>>
>> are available in the git repository at:
>> ? git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/cleanup
>
> Pulled and resolved a conflict with Marc's "ARM: tegra2: convert to
> CONFIG_MULTI_IRQ_HANDLER" patch, which leaves entry-macro.S
> almost empty with these contents:
>
> ? ? ? ?.macro ?disable_fiq
> ? ? ? ?.endm
>
> ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ?.endm
>
> Please confirm if this is the correct resolution.
>

Yep, that's the expected resolution. Thanks!


-Olof
