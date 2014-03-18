From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Mar 2014 14:07:02 +0530
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <CACRpkdYZMzw31NkA4uSq+ZowzOnZgZthXhZri-eJY2Ozb8aNRQ@mail.gmail.com>
References: <5316FFCE.1060603@ti.com>
 <1394018461-757-1-git-send-email-holler@ahsoftware.de>
 <CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>
 <5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5326F8C5.5090406@ti.com>
 <CACRpkdYZMzw31NkA4uSq+ZowzOnZgZthXhZri-eJY2Ozb8aNRQ@mail.gmail.com>
Message-ID: <532805AE.9000806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 March 2014 07:35 PM, Linus Walleij wrote:
> On Mon, Mar 17, 2014 at 2:29 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> 
>> One thing to note is that this driver is used by keystone too and all
>> its users are DT-only. Although I do not see any in-kernel DT GPIO users
>> even there.
>>
>> I can confirm the patch does not break my gpiolib based test module
>> (test with and without DT), but then it did not have an issue even before.
> 
> Is that a Tested-by tag? :-)

Yes.

Tested-by: Sekhar Nori <nsekhar@ti.com>

> 
> If you're also convinced that fix is safe I'll push it as a fix to v3.14-rcN
> if for nothing else so for getting Mr. Holler to stop poking me in the
> chest.

It is safe - at the least it does not break anything that is already
working. I guess the decision to put it into -rc depends on whether you
consider out of tree dtbs to be a valid usecase for the kernel.

Thanks,
Sekhar
