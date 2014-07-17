From: xerofoify@gmail.com (Nick Krause)
Date: Wed, 16 Jul 2014 21:13:19 -0400
Subject: [PATCH] mach-s3c64xx: Remove all defintions not related to
 regs-clocks
In-Reply-To: <36350.1405374230@turing-police.cc.vt.edu>
References: <1405361664-5210-1-git-send-email-xerofoify@gmail.com>
 <36350.1405374230@turing-police.cc.vt.edu>
Message-ID: <CAPDOMVgOfaf7qHXGSdwpyT4edo_ZjbbnkP7UYNbzkRzudW_f-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 5:43 PM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Mon, 14 Jul 2014 14:14:24 -0400, Nicholas Krause said:
>> This patch addresses the fix me message in this file that states to
>> remove all definitions not related to reg-clocks in this header
>> file.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>>  arch/arm/mach-s3c64xx/include/mach/regs-clock.h | 22 +---------------------
>>  1 file changed, 1 insertion(+), 21 deletions(-)
>
>> -#endif /* _PLAT_REGS_CLOCK_H */
>> +/#endif /* _PLAT_REGS_CLOCK_H */
>
> You're kidding us, right? Given that this was obviously *not* compile
> tested at all, why should we believe that in fact all those #defines
> are in fact no longer used?
>
> Hint: There's a very high chance that somebody stuck that FIXME in there rather
> than just cleaning it up themselves precisely *because* it was still in use in
> an inconvenient to fix place in the tree..
>
I build the arch/arm directory I seem to me hitting a error.
 arch/arm/xen/enlighten.c:17:29: fatal error: asm/system_misc.h: No
such file or directory
 #include <asm/system_misc.h>
I am also looking into fixing this issue.
Cheers Nick
