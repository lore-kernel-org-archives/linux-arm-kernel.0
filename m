From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 3 Feb 2016 03:54:59 +0000
Subject: [PATCH] ARM: vmlinux.lds: assert that ROM and RAM don't overlap
 when XIP_KERNEL=y
In-Reply-To: <CA+ZsKJ5hCSY39D5UBpie5u7XmrJfb0xXBA11hc3z2t8_niKw9g@mail.gmail.com>
References: <1454346154-12931-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160203003158.GZ10826@n2100.arm.linux.org.uk>
 <CA+ZsKJ5hCSY39D5UBpie5u7XmrJfb0xXBA11hc3z2t8_niKw9g@mail.gmail.com>
Message-ID: <HKXPR06MB0565FC1048E3851BA9A58B108AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The long term goal is to move the XIP stuff out of this file, so I 
> > think it's better to avoid touching this until the split has happened.
> >
> > I'd _much_ rather see the split happen first, and then fixes applied, 
> > rather than trying to fix the existing unmaintainable mess.
>
> Is that split being actively worked on?  If so by whom?

I submitted "[PATCH v2] ARM: xip: Move XIP linking to a separate file" back in November which seemed pretty straight forward.

Although, it didn't make it too far (other than Nicolas acking it)

Chris
