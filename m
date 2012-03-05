From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Mar 2012 20:58:41 +0000
Subject: [PATCH 0/9] DMA engine cookie handling cleanups
In-Reply-To: <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
Message-ID: <20120305205841.GB17791@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 09:50:51PM +0100, Linus Walleij wrote:
> On Mon, Mar 5, 2012 at 9:14 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > This patch series cleans up the handling of cookies in DMA engine drivers.
> > This is done by providing a set of inline library functions for common
> > tasks:
> 
> Overall this looks good, but I have a problem:
> patch [1/9] does not appear in any subscribed accounts (it may be on
> my @stericsson.com address, will check tomorrow)

Patch 1 is just a couple of line changes to mv_xor.[ch]
