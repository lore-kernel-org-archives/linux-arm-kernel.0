From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 May 2013 17:34:30 -0700
Subject: Booting mainline kernels on Samsung ARM-based Chromebooks
Message-ID: <CAOesGMgrT8fCRcnJYP=tcr4Szp5B6NtQxsQeb6pEv24edHLYFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a quick note that as of v3.10-rc4 (or -rc3 + arm-soc fixes
branch) there should be enough pieces in mainline to boot a Chromebook
to a useful state without out-of-tree patches.

For more info, see:

https://plus.google.com/u/0/109993695638569781190/posts/bQpzEGG15G8

There's plenty of stuff not working yet, but it'll come up with
simplefb, keyboard, trackpad and USB 2.0 for now.


-Olof
