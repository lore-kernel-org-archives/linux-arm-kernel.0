From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 13:21:05 +0100
Subject: [RFC PATCH 01/10] arm64: introduce KIMAGE_VADDR as the virtual
 base of the kernel region
In-Reply-To: <20160103145008.GA1642@svinekod>
References: <1451301654-32019-1-git-send-email-ard.biesheuvel@linaro.org>
 <11016384.rorhLcDd8i@wuerfel> <20160103145008.GA1642@svinekod>
Message-ID: <2697196.BQeEylXYbs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 03 January 2016 14:50:10 Mark Rutland wrote:
> 
> > - once we have a random number in the bootloader, we should also pass that
> >   through a DT property. This has been discussed multiple times in the past
> >   and I think we had reached consensus already but don't know if we had
> >   agreed on a specific DT property that contains the random number seed.
> 
> Any links for this? I don't recall spotting this discussion.

One discussion I found in the mail archives is in this thread
https://lkml.org/lkml/2014/2/12/518, I also remember discussing it in person
at some conference, obviously no archive of that.

	Arnd
