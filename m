From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 2 Feb 2016 23:08:39 -0500 (EST)
Subject: [PATCH] ARM: vmlinux.lds: assert that ROM and RAM don't overlap
 when XIP_KERNEL=y
In-Reply-To: <HKXPR06MB0565FC1048E3851BA9A58B108AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
References: <1454346154-12931-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160203003158.GZ10826@n2100.arm.linux.org.uk>
 <CA+ZsKJ5hCSY39D5UBpie5u7XmrJfb0xXBA11hc3z2t8_niKw9g@mail.gmail.com>
 <HKXPR06MB0565FC1048E3851BA9A58B108AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1602022305200.32766@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Feb 2016, Chris Brandt wrote:

> > > The long term goal is to move the XIP stuff out of this file, so I 
> > > think it's better to avoid touching this until the split has happened.
> > >
> > > I'd _much_ rather see the split happen first, and then fixes applied, 
> > > rather than trying to fix the existing unmaintainable mess.
> >
> > Is that split being actively worked on?  If so by whom?
> 
> I submitted "[PATCH v2] ARM: xip: Move XIP linking to a separate file" back in November which seemed pretty straight forward.
> 
> Although, it didn't make it too far (other than Nicolas acking it)

For your ARM patches to be merged upstream, once you feel they've 
received sufficient review on the list, you then have to submit them 
here:

http://www.arm.linux.org.uk/developer/patches/


Nicolas
