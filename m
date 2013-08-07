From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Aug 2013 22:43:31 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: Add spinlocks
In-Reply-To: <CACRpkdarfjs-RVb9VFb1vkiFsnnnv5rgTzbB1ru92B3G5MrxUA@mail.gmail.com>
References: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375612728-20501-3-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdYS-7MPTTSg4psJ3NZ_jhA15aMeFLoxFNAN7hSqe4hRTA@mail.gmail.com>
 <20130807191640.GG2911@lukather>
 <CACRpkdarfjs-RVb9VFb1vkiFsnnnv5rgTzbB1ru92B3G5MrxUA@mail.gmail.com>
Message-ID: <20130807204331.GH2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 09:59:04PM +0200, Linus Walleij wrote:
> On Wed, Aug 7, 2013 at 9:16 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> >> It is also too big to go into fixes.
> >>
> >> I think it may be requiring the other queued Allwinner things,
> >> so it is better if I apply this on the devel branch after looking over
> >> that Allwinner A20/A31 stuff?
> >
> > The A20/A31 stuff shouldn't conflict with this one, but yes, I you
> > prefer to do it that way, it's fine for me.
> 
> I applied it for fixes anyway. Too much to worry about with the
> cross dependency between fixes and devel otherwise.

Ok, great!

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/ff242696/attachment.sig>
