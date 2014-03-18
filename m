From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Mar 2014 16:24:17 +0530
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <532815A8.9090807@ahsoftware.de>
References: <5316FFCE.1060603@ti.com>
 <1394018461-757-1-git-send-email-holler@ahsoftware.de>
 <CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>
 <5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5326F8C5.5090406@ti.com>
 <CACRpkdYZMzw31NkA4uSq+ZowzOnZgZthXhZri-eJY2Ozb8aNRQ@mail.gmail.com>
 <532805AE.9000806@ti.com> <532815A8.9090807@ahsoftware.de>
Message-ID: <532825D9.4050708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Tuesday 18 March 2014 03:15 PM, Alexander Holler wrote:
> Am 18.03.2014 09:37, schrieb Sekhar Nori:
> 
>> It is safe - at the least it does not break anything that is already
>> working. I guess the decision to put it into -rc depends on whether you
>> consider out of tree dtbs to be a valid usecase for the kernel.
> 
> That's all DT is about, getting rid of the necessity for in-tree
> hw-descriptions. ;)
> 
> But I don't need any rush here, I'm just unable to understand why the
> -rc phase isn't used for bug fixing as I believe that's what this phase
> is for.

The push back you are seeing is because this is pretty late in -rc
cycle. If this push back was not there the bug fix cycle would probably
never close.

In all probability, if this was -rc2 or even -rc3 there would not be so
much discussion.

Thanks,
Sekhar
