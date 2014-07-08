From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Jul 2014 13:53:26 +0200
Subject: [PATCH] regulator: core: Still free GPIOs using gpio_free()
In-Reply-To: <CACRpkdZ7ai0AShAen=AkaorHt0ObhYCDC-OuHG-9nVb3LLt3KQ@mail.gmail.com>
References: <1404215726-2480-1-git-send-email-broonie@kernel.org>
 <20140701120622.GJ32514@n2100.arm.linux.org.uk>
 <20140701121142.GM23300@sirena.org.uk>
 <CAAVeFuJqRW0ih8Mg9MFwLf=wQ7eVK5+pm8deW0vTUdozJ16FfQ@mail.gmail.com>
 <20140701122717.GN23300@sirena.org.uk>
 <CACRpkdZ7ai0AShAen=AkaorHt0ObhYCDC-OuHG-9nVb3LLt3KQ@mail.gmail.com>
Message-ID: <20140708115326.GU30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 10:33:23AM +0200, Linus Walleij wrote:
> On Tue, Jul 1, 2014 at 2:27 PM, Mark Brown <broonie@kernel.org> wrote:

> > Right, but Linus said we didn't need this conversion to descriptors so
> > I'm a bit confused as to what the issue he was raising was.

> Now I'm probably confusing myself...

> All drivers should as far as possible use descriptors internally, doing
> things like gpio_to_desc() only for backward-compatibility where
> necessary, with the intent of eventually ridding the integer interfaces
> entirely.

> It may be an eternal project, but hey, we are atleast two of us
> pursuing it.

OK, so in that case Russell's code should be fine then and we don't need
to do anything - great!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/7ce51eba/attachment.sig>
