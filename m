From: ijc@debian.org (Ian Campbell)
Date: Fri, 21 Aug 2015 13:24:17 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
Message-ID: <1440159857.19360.50.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi kirkwood-upstream,

We (Debian) have had a couple of reports of I/O errors running Debian
on kirkwood, specifically it seems to relate to later kernels (e.g.
4.0+) and I _suspect_ (without proof) that it may be due to the switch
from board files to the DTS based kernel, or some change implied by
this (e.g. different SATA driver now or timeouts have changed
perhaps?).

There are two reports that writing to mdtblock (as a raw device, where
the bootloader expects to find the kernel etc) causes SATA to fall
apart. Please see this thread:
http://mid.gmane.org/<
CAMLx2CqT+2fzfa9_Bc0fXLAJ1wJ+yQuJvUThJwN48kGJTJhJxg@mail.gmail.com>

There was an earlier iteration of the same thing as the above:
http://mid.gmane.org/<CAKzmTe1vUGjiPt8k3VHNUP9aHs7zF9wCXoXOo8XFjD-YEH-U5A@mail.gmail.com>

Thanks for any pointers you can give. I've copied the reporters as well
as the debian-arm list.

@debian-arm: I had the impression there had been more reports than
these two/three but I'm not seeing them in my folder, if you know of
others then please chime in.

Ian.
