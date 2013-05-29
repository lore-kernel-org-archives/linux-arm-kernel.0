From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 29 May 2013 10:07:16 +0900
Subject: Booting mainline kernels on Samsung ARM-based Chromebooks
In-Reply-To: <CAOesGMgrT8fCRcnJYP=tcr4Szp5B6NtQxsQeb6pEv24edHLYFw@mail.gmail.com>
References: <CAOesGMgrT8fCRcnJYP=tcr4Szp5B6NtQxsQeb6pEv24edHLYFw@mail.gmail.com>
Message-ID: <001901ce5c08$dc248e00$946daa00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 29, 2013 9:35 AM, Olof Johansson wrote:
> 
> Just a quick note that as of v3.10-rc4 (or -rc3 + arm-soc fixes
> branch) there should be enough pieces in mainline to boot a Chromebook
> to a useful state without out-of-tree patches.
> 
> For more info, see:
> 
> https://plus.google.com/u/0/109993695638569781190/posts/bQpzEGG15G8

Oh, great!

As Kukjin Kim mentioned, we have wanted to support mass product
without out-of-tree patches. Also, I have gone the extra mile
to do this.

> 
> There's plenty of stuff not working yet, but it'll come up with
> simplefb, keyboard, trackpad and USB 2.0 for now.

I will look at the patches about simplefb, USB 2.0, and so on.
If possible, I will review it.
Good luck.

Best regards,
Jingoo Han

> 
> 
> -Olof
> --
