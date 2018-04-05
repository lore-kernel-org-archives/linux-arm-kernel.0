From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 14:51:20 +0200
Subject: [PATCH v1 1/2] arm: npcm: modify configuration for the NPCM7xx
 BMC.
In-Reply-To: <CAFd5g47AeTtU_uYNOuDKroBwf_FMd+4Z7WgcCM5wyj2e_PEZrQ@mail.gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
 <1521155412-29229-2-git-send-email-tmaimon77@gmail.com>
 <CAFd5g47AeTtU_uYNOuDKroBwf_FMd+4Z7WgcCM5wyj2e_PEZrQ@mail.gmail.com>
Message-ID: <CAK8P3a2AtJUmP+cNVEdyiKJSAst+svNqvHrssgseAHnTzqj40w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 6:56 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> On Thu, Mar 15, 2018 at 4:16 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
>> Modify configuration and MakeFile
>> for the Nuvoton NPCM and NPCM7xx BMC.
>
>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> ---
>>   arch/arm/mach-npcm/Kconfig  | 40 +++++++++++-----------------------------
>>   arch/arm/mach-npcm/Makefile |  4 +++-
>>   2 files changed, 14 insertions(+), 30 deletions(-)
>
> <snip>
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Sorry for missing this earlier, I did ask for the rework but then
didn't see it as it
wasn't in my arm at kernel.org inbox.

Tomer, please make sure that all patches you want to have included in
the kernel are sent to that address, while patches you want to have reviewed
are not sent to it.

Normally I don't apply patches during the merge window, but this one fixes
some build problems, so I've decided to take it.

       Arnd
