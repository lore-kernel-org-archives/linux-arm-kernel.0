From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Jun 2015 14:46:24 +0200
Subject: [PATCH 0/3] GPIO support for BRCMSTB
In-Reply-To: <20150602162830.GI2067@n2100.arm.linux.org.uk>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkda3EDa7YdzeT6FQ=cQw1RrDath7pQsCos-JeB2y4r18gw@mail.gmail.com>
 <CADtm3G45-u82Rp_0dHf2EfdMokf8E4FaQ84PHnocpvXxU+5_+g@mail.gmail.com>
 <CACRpkdaTYAr-7K5_QZh1CyeyA1224obqEB2Sz8UHZmrWcfv+ow@mail.gmail.com>
 <CADtm3G4ao=3sHx2F1+V9rwS=jWf6ZdEQi4d24HxQ6MEc+CQ8CQ@mail.gmail.com>
 <CACRpkdY_-zq-1srBC213MK_RoVvPsfTpRTQyx-4yRvCOV5JdxQ@mail.gmail.com>
 <20150602162830.GI2067@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbDYGyX4-7U4rx3vzH2do7e=3U2qeqa=2j11E6z1Bqqyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 6:28 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 02, 2015 at 11:05:21AM +0200, Linus Walleij wrote:
>> ... and have the
>> IRQ handler return IRQ_NONE if the IRQ comes from this
>> bank, or IRQ_HANDLED if it has handled an IRQ from its own
>> space.
>
> I'm not sure that's worded correctly or not, but... fwiw, all IRQ handlers
> _should_ be returning IRQ_NONE if the IRQ does not belong to them whether
> or not they're shared handlers.

Yup that's right. Sorry for being unclear.

Yours,
Linus Walleij
