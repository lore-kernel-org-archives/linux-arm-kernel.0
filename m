From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Thu, 23 Nov 2017 00:34:08 +0100
Subject: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
In-Reply-To: <20171121174942.GK31757@n2100.armlinux.org.uk>
References: <20171121172751.29545-1-Jason@zx2c4.com>
 <20171121173857.GJ31757@n2100.armlinux.org.uk>
 <CAHmME9quDFbdOR9hKRz-Px=Mh3FvYEyhVrs4V_+JT+GjDajMrA@mail.gmail.com>
 <20171121174942.GK31757@n2100.armlinux.org.uk>
Message-ID: <CAHmME9oMTNJFnOwfhu26QSRSP92Axbc-+v9cCPsTKxekZvGvxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 6:49 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> What if we locate the "badr" instruction to the same offset - does
> that trigger the binutils bug?  Note that the grep expression will
> need updating...

Nope, this too does not reproduce it. I'm having a bit of trouble
making a minimal test case to reproduce it. But I can reproduce it
everytime by simply assembling the file in question using that
binutils.

Jason
