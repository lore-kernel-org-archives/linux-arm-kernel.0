From: andrea.adami@gmail.com (Andrea Adami)
Date: Fri, 15 Mar 2013 10:31:33 +0100
Subject: [Suggestion] Latest randconfig build errors for Head.S
In-Reply-To: <514270D2.9010205@asianux.com>
References: <51415428.1070401@asianux.com>
 <20130314234323.GD4977@n2100.arm.linux.org.uk>
 <514270D2.9010205@asianux.com>
Message-ID: <CAAQYJAvXLV38shKncAKKqgQ9G0SnXjh+=aJHBdhd29yzVtL80A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 1:52 AM, Chen Gang <gang.chen@asianux.com> wrote:
> ? 2013?03?15? 07:43, Russell King - ARM Linux ??:
>> So our wonderful toolchain has decided to start producing NULL warnings
>> for every "mcr     p15, 0, rX, c7, c10, 4" instruction?  I'd just ignore
>> them and hope that the toolchain people fix it.

AFAIK Arnd is aware and waiting for feedback about his patch:

ARM: compressed/head.S: work around new binutils warning   Arnd Bergmann

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/144846.html

Regards

Andrea
>
>   ok, thanks.
>
>   :-)
>
> --
> Chen Gang
>
> Asianux Corporation
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
