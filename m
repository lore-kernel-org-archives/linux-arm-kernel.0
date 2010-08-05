From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Aug 2010 10:06:40 -0500
Subject: [PATCH] arm: R_ARM_REL32 relocation support
In-Reply-To: <19546.31437.994840.466509@pilspetsen.it.uu.se>
References: <1280993763-15254-1-git-send-email-olof@lixom.net>
	<19546.31437.994840.466509@pilspetsen.it.uu.se>
Message-ID: <20100805150640.GA25061@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 05, 2010 at 10:48:13AM +0200, Mikael Pettersson wrote:
> Olof Johansson writes:
>  > commit d0679c730395d0bde9a46939e7ba255b4ba7dd7c moved -fno-dwarf2-cfi-asm to be
>  > powerpc-only, causing R_ARM_REL32 to be used with some toolchains on ARM.
>  > 
>  > Implement support for it to make modules work with more toolchains.
>  > 
>  > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Michal Marek's patch(*) to use -fno-dwarf2-cfi-asm already exists
> and is IMO the correct solution in that it addresses the cause
> of the problem rather than its symptoms.
> 
> NAK from me for now.
> 
> (*) http://lkml.org/lkml/2010/7/26/154

Sigh. I searched the list for related patches and didn't see any. Sorry for the duplicate.


-Olof
