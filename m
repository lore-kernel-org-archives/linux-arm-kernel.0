From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 11:59:13 +0200
Subject: [PATCH 12/26] ARM: pxa: pxa95x/saarb depends on pxa3xx code
In-Reply-To: <CAMPhdO-1ZZ28Z7affqgXWqwnbbAEhyC3_Tbgtdp2v+s4bqqQRQ@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-13-git-send-email-arnd@arndb.de>
	<CAMPhdO-1ZZ28Z7affqgXWqwnbbAEhyC3_Tbgtdp2v+s4bqqQRQ@mail.gmail.com>
Message-ID: <201110071159.13234.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 October 2011, Eric Miao wrote:
> PXA95x is actually PJ4 based, which is ARMv7/v6 compatible, not
> like it's predecessor PXA93x. Although they are currently sharing
> some code, I expect a fork in the near future. To cause less confusion
> here, I'd propose to further introduce pxa95x.h, and to remove
> the unnecessary #include of <mach/mfp.h> and <mach/mfp-pxa930.h>

Yes, looks good.

	Arnd
