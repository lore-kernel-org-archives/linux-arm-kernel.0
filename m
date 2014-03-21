From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Mar 2014 09:28:16 +0100
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
Message-ID: <CACRpkdZwhP-wMDeNTEq6ELPsYC48xmppzGYTRLSzUewbqhrMvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 10:45 AM, Alexander Holler <holler@ahsoftware.de> wrote:

> But I don't need any rush here, I'm just unable to understand why the -rc
> phase isn't used for bug fixing as I believe that's what this phase is for.

Right now it is mostly a practical issue to me, as I applied the patch to
the devel (for-next) branch, then committed new development on top of
it.

If I send it for fixes now the same patch will come in two ways as I
really do not like to rebase my tree at this point.

So I'd prefer to keep this for next and then have it tagged for stable as
v3.14 is released, if that is OK?

It's as simple as sending a mail to Greg once it's upstream.

Yours,
Linus Walleij
