From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 29 Apr 2018 17:37:32 +0200
Subject: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
In-Reply-To: <CABdtJHun8DWbr-bUgwQEK61UXMLh5pPkwvUTF+KxhHmJaXEr-A@mail.gmail.com>
References: <20180422142151.17910-1-contact@paulk.fr>
 <20180422143911.GB16141@n2100.armlinux.org.uk>
 <8012696a7bf0132dd2361a896bf0abfbe8a3084e.camel@paulk.fr>
 <d167cc6987fdb7f04493c634873d430dcd216887.camel@paulk.fr>
 <CABdtJHun8DWbr-bUgwQEK61UXMLh5pPkwvUTF+KxhHmJaXEr-A@mail.gmail.com>
Message-ID: <b7aca3a0e1f90e5048c5ca81c42bf41b318b260b.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le dimanche 29 avril 2018 ? 16:09 +0200, Jon Nettleton a ?crit :
> You have either an initial early developer unit (pre-production) that
> was assembled like this for testing, or a unit that someone
> specifically ordered assembled this way.  You can see from the
> schematic that this option does not have a CD-pin because it is meant
> to be a more permanent storage option.

It turns out that the card-detection mechanism was somewhat broken on my
device (which does have a regular push slot). It would report card-
detect only when the card was not fully inserted, and stop asserting
card-detect when it was pushed fully.

I used a fitting tweezer to move the mechanical parts around and got it
to also detect the card when it is pushed all the way.

So no change is necessary after all, it was just my device that needed
fixing.

Thanks for the helpful answers!

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180429/b820f562/attachment-0001.sig>
