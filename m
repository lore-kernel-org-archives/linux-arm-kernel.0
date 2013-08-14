From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 14 Aug 2013 13:56:52 +0100
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <20130814124904.GQ23006@n2100.arm.linux.org.uk>
References: <20130812164548.GE23006@n2100.arm.linux.org.uk>
 <CAFEAcA97PuORg920f-A_8rvCgBq=k5Y=0W6m2Nv8nnzjY19Utg@mail.gmail.com>
 <20130812200628.GG23006@n2100.arm.linux.org.uk>
 <CAFEAcA9BA7zfaO1J5zVaEcG-AgOo6dyiew08-o2eObuBe-KWig@mail.gmail.com>
 <20130812212149.GH23006@n2100.arm.linux.org.uk>
 <CAFEAcA_0kzS=Z5oTxrr=B74wjf1x=M6dXwH7Fcgf77Pca90Gjw@mail.gmail.com>
 <20130812221250.GI23006@n2100.arm.linux.org.uk>
 <20130812230408.GA4420@roeck-us.net>
 <20130814103346.GN23006@n2100.arm.linux.org.uk>
 <CAFEAcA8u_c=seOQ+y44H2Vpefyx4EisiZ-ZqBxuPsyoYjCt3vQ@mail.gmail.com>
 <20130814124904.GQ23006@n2100.arm.linux.org.uk>
Message-ID: <CAFEAcA-V=DqomASFDaQhOsnXPePZ3iA7AVV8pSyRkDxbmT4n8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2013 13:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 14, 2013 at 01:44:44PM +0100, Peter Maydell wrote:
>> Yes, I definitely think we should test on the hardware before we
>> land yet another change to this PCI code that hasn't really been
>> thoroughly tested on anything. I have the board/backplane on my
>> desk but it'll be later in the week before I can do the testing
>> (currently still messing with uboot config to get it to actually
>> boot a kernel).
>
> Realview or Versatile?  I still need to sort out Realview.

PB926, so versatile. Let's get that one straightened out first,
since at the moment the kernel has no realview PCI support at
all. I should be able to get a PB1176 to go in the backplane
for testing that, though.

-- PMM
