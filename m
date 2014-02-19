From: bcm@fixthebug.org (Christian Daudt)
Date: Tue, 18 Feb 2014 22:12:20 -0800
Subject: [PATCH 12/28] Remove GENERIC_TIME
In-Reply-To: <52F7DED2.1020509@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-13-git-send-email-richard@nod.at>
 <1391972239.567717844@f148.i.mail.ru> <52F7DED2.1020509@nod.at>
Message-ID: <CAEPRUYprJH5AG-P=c+Oj4NEqiv=DBgTy9cX0NNOcez+vY9VxeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 9, 2014 at 12:02 PM, Richard Weinberger <richard@nod.at> wrote:
> Am 09.02.2014 19:57, schrieb Alexander Shiyan:
>>> The symbol is an orphan, get rid of it.
>>>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>> arch/arm/mach-bcm/Kconfig | 1 -
>>> 1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>>> index b1aa6a9..8dd5fbf 100644
>>> --- a/arch/arm/mach-bcm/Kconfig
>>> +++ b/arch/arm/mach-bcm/Kconfig
>>> @@ -19,7 +19,6 @@ config ARCH_BCM_MOBILE
>>> select CPU_V7
>>> select CLKSRC_OF
>>> select GENERIC_CLOCKEVENTS
>>> -    select GENERIC_TIME
>>> select GPIO_BCM_KONA
>>> select SPARSE_IRQ
>>> select TICK_ONESHOT
>>> --
>>> 1.8.4.2
>>

Applied to armsoc/for-3.15/soc
Also added signed-off-by for Alexander Shyian and Paul Bolle.

 Thanks,
   csd
