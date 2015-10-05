From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Oct 2015 11:03:16 +0200
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <56122906.9010102@free.fr>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <560ED1FB.9010000@free.fr>
 <yw1xbncgluad.fsf@unicorn.mansr.com>
 <20151003103219.1e10bdeb@arm.com> <560FA4B5.1040709@free.fr>
 <20151003111231.544ae8e2@arm.com>
 <20151005054652.GI26391@xsjsorenbubuntu> <56122906.9010102@free.fr>
Message-ID: <CACRpkdb31n84UwRxzds7nitOO3QXsoaKFhJWSOVZQ+8dU7XKQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 5, 2015 at 9:38 AM, Mason <slash.tmp@free.fr> wrote:

> 2) I was told that some platforms "turn off" the TWD block in
> low-power modes (like during WFI), and therefore must be marked
> as unreliable in "C3" (FEAT_C3STOP).
>
> I have a patch to selectively not mark the TWD as unreliable.
> (I will make a formal submission today.)

This sounds like something that should be done with a device
tree bool. Don't forget to patch
Documentation/devicetree/bindings/arm/twd.txt

Yours,
Linus Walleij
