From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 08 Nov 2016 09:12:00 +1030
Subject: [PATCH v2 1/6] pinctrl-aspeed-g5: Never set SCU90[6]
In-Reply-To: <CACRpkdbH8eubEHwHCsdJsmqVp3hkBW4vb5DCHvJxz+tyfFqbKQ@mail.gmail.com>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-2-git-send-email-andrew@aj.id.au>
 <CACPK8Xcbv5VjE9deETV6zC4cPSfeBSgP96QYqV_ebAgtB9Jwtw@mail.gmail.com>
 <CACRpkdbH8eubEHwHCsdJsmqVp3hkBW4vb5DCHvJxz+tyfFqbKQ@mail.gmail.com>
Message-ID: <1478558520.6206.4.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-11-07 at 10:34 +0100, Linus Walleij wrote:
> > On Thu, Nov 3, 2016 at 11:59 PM, Joel Stanley <joel@jms.id.au> wrote:
> 
> > In the future I think we should send fixes separately from the rest of
> > the series, so it's clear to Linus where we expect patches to end up.
> > 
> > Perhaps Linus can share his preference with us?
> 
> Just make it clear to me where the patch is headed, if it is
> a fix or a new feature.
> 
> Also mixing stuff in big series is of course problematic because
> all the CC:in on MFD patches and whatnot that I don't apply
> makes the picture blurry, but sometimes it is anyways needed
> for context so it is a soft requirement.

Context was my concern here and I would otherwise have split the rest
of the patches along mfd/pinctrl boundaries. I felt the situation was
odd enough to warrant presenting the full picture.

Andrew

> 
> Yours,
> Linus Walleij
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/472a2ae8/attachment.sig>
