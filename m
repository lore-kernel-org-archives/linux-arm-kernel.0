From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Nov 2015 22:09:27 +0100
Subject: [PATCH RESEND v2 3/4] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <5642198C.2040205@broadcom.com>
References: <1446839371-22601-1-git-send-email-kapilh@broadcom.com>
 <1446839371-22601-4-git-send-email-kapilh@broadcom.com>
 <CACRpkdZN-iwdR_VwktdHsw+rGQLhCgmWnERYVDE+KaYOqJR30w@mail.gmail.com>
 <CAGVrzca34xrVznoEE2e26JyR11Q9L1sT4mJcNZ=NuprqUnZnjw@mail.gmail.com>
 <5642198C.2040205@broadcom.com>
Message-ID: <CACRpkdbMoqhZqqiqhEFVnRoJ+f2Tje7Du4BKET_s+DaUCcMzkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 5:21 PM, Kapil Hali <kapilh@broadcom.com> wrote:
> On 11/10/2015 7:59 AM, Florian Fainelli wrote:

>>> Also give it a sane name, bcm_sec_boot_address or so.
>>> "secondary_boot" sounds like a function you call to boot
>>> the second core.
>>
>> Agree with that, there could be a better name which better reflects
>> this is a variable.
>>
> As this change is consolidating SMP implementation, I kept the same
> name of the variable which was used in kona_smp.c so that the changes
> in the common code is minimal. Also, the fact that the change is part
> of up-streamed code, I didn't alter with the variable name. Shall I
> change it in the next patch?

Sure do it any way as long as the end result looks fine.
It was not a big issue anyways.

Yours,
Linus Walleij
