From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2016 10:39:48 +0000
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
Message-ID: <20160102103948.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 04:50:54PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> I am new to the Linux DMA APIs.
> 
> First, I started by reading Documentation/DMA-API.txt,
> but I am confused with the term "consistent memory".

Just read "coherent memory" instead - the documentation confusingly uses
the two terms to refer to the same thing.  I think there was a patch a
while back to replace "consistent" with "coherent" in this document,
though I'm not sure what happened to it.

I think you have answers to your other points by others in this thread.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
