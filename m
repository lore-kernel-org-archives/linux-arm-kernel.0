From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Wed, 29 Oct 2014 13:20:14 +0800
Subject: [RFC V2] arm/arm64:add CONFIG_HAVE_ARCH_BITREVERSE to support
 rbit instruction
In-Reply-To: <CAL_JsqJYBoG+nrr7R3UWz1wrZ--Xjw5X31RkpCrTWMJAePBgRg@mail.gmail.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
 <CAL_JsqJYBoG+nrr7R3UWz1wrZ--Xjw5X31RkpCrTWMJAePBgRg@mail.gmail.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D18262@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Rob Herring [mailto:robherring2 at gmail.com]
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> >> 9532f8d..263c28c 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -36,6 +36,7 @@ config ARM64
> >>       select HARDIRQS_SW_RESEND
> >>       select HAVE_ARCH_AUDITSYSCALL
> >>       select HAVE_ARCH_JUMP_LABEL
> >> +     select HAVE_ARCH_BITREVERSE
> >>       select HAVE_ARCH_KGDB
> >>       select HAVE_ARCH_TRACEHOOK
> >>       select HAVE_BPF_JIT
> 
> The kconfig lists should be sorted.
> 
> Rob

Got it ,
Thanks for your remind.
