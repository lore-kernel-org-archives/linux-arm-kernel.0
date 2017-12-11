From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Dec 2017 13:46:27 +0000
Subject: [PATCH net-next v5 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <CAA93ih2i+G2uyL8O-4F1juR1DpUYCd1U1dBCRRM5Xdd3L-m95g@mail.gmail.com>
References: <1512979049-15930-3-git-send-email-hayashi.kunihiko@socionext.com>
 <CAOFm3uELNTgenR91-QGL1QQ08zA0N0rQbH4hzCzFKtRw6TckLw@mail.gmail.com>
 <20171211210455.170A.4A936039@socionext.com>
 <CAA93ih2i+G2uyL8O-4F1juR1DpUYCd1U1dBCRRM5Xdd3L-m95g@mail.gmail.com>
Message-ID: <20171211134627.GU10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 10:34:17PM +0900, Masami Hiramatsu wrote:
> IMHO, even if we use SPDX license identifier, I recommend to use
> C-style comments as many other files do, since it is C code.
> If SPDX identifier requires C++ style, that is SPDX parser's issue
> and should be fixed to get it from C-style comment.

See the numerous emails on this subject already.  The issue of C
vs C++ comments has come up many times by many different people, but
the result is the same.  That's not going to happen.  Linux kernel
C files are required to use "//" for the SPDX identifier by order
of Linus Torvalds.

Linus has also revealed in that discussion that he has a preference
for "//" style commenting for single comments, so it seems that the
kernel coding style may change - but there is no desire for patches
to "clean up" single line comments to use "//".

For further information, and to see the discussion that has already
happened, the arguments that have been made about style, see the
threads for the patch series that tglx has been posting wrt documenting
the SPDX stuff for the kernel.

Thanks (let's stop rehashing the same arguments.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
