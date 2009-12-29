From: pulluru.linux@rediffmail.com (pulluru )
Date: 29 Dec 2009 07:19:10 -0000
Subject: =?utf-8?B?QXJtIGxpbnV4IEFzeW1tZXRyaWMgbXVsdGljb3JlIHByb2dyYW1taW5n?=
Message-ID: <20091229071910.21683.qmail@f6mail-145-191.rediffmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,



I have an multi-core arm processor. I have a requirement to make core1 run Linux and to utilize core2(currently in WFI state) for specific application, say example: running a network packet engine on core2, for increasing performance.



I am a beginner to arm and kernel programming. I would like to wake-up the core2 from WFI state and run my own program.



Could you please give me some pointers to the linux arch/kernel code where the CPU core initialization happens?



Thanks.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091229/6b671165/attachment-0001.htm>
