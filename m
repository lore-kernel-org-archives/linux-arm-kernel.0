From: holler@ahsoftware.de (Alexander Holler)
Date: Tue, 18 Mar 2014 10:45:12 +0100
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <532805AE.9000806@ti.com>
References: <5316FFCE.1060603@ti.com>
 <1394018461-757-1-git-send-email-holler@ahsoftware.de>
 <CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>
 <5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5326F8C5.5090406@ti.com>
 <CACRpkdYZMzw31NkA4uSq+ZowzOnZgZthXhZri-eJY2Ozb8aNRQ@mail.gmail.com>
 <532805AE.9000806@ti.com>
Message-ID: <532815A8.9090807@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.03.2014 09:37, schrieb Sekhar Nori:

> It is safe - at the least it does not break anything that is already
> working. I guess the decision to put it into -rc depends on whether you
> consider out of tree dtbs to be a valid usecase for the kernel.

That's all DT is about, getting rid of the necessity for in-tree 
hw-descriptions. ;)

But I don't need any rush here, I'm just unable to understand why the 
-rc phase isn't used for bug fixing as I believe that's what this phase 
is for.

Most people are unable to track the various -next trees, therefor many 
failures only come up when stuff reaches mainline where it might be 
tested by some more people. And if all bugs found in the -rc phase are 
fixed in -next only, the -rc phase would be useless.

And it just happened to me too often, that even silly bugfixes (like 
oneliners) needed between 5 and 9 months to reach a stable kernel and 
thus users.

Regards,

Alexander Holler
