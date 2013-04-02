From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Apr 2013 14:21:02 +0000
Subject: [GIT PULL] ARM: cns3xxx: v3.9-rc1_cns3xxx_fixes
In-Reply-To: <20130330201753.GA15370@lizard>
References: <20130330201753.GA15370@lizard>
Message-ID: <201304021421.02822.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 March 2013, Anton Vorontsov wrote:
> Hello Arnd,
> 
> Please pull v3.9-rc1_cns3xxx_fixes tag from the cns3xxx git tree, the tag
> includes Mac Lin's work to revive CNS3xxx booting:
> 
>  "Since commit 0536bdf33faf (ARM: move iotable mappings within the vmalloc
>  region), [...] the pre-defined iotable mappings is not in the vmalloc
>  region. [...] move the iotable mappings into the vmalloc region, and
>  merge the MPCore private memory region (containing the SCU, the GIC and
>  the TWD) as a single region."
> 
> Plus there is a small cosmetic fix, also from Mac Lin.

Given that we're pretty late for 3.9 now, I've only merged the first patch
into the fixes branch but left the second for the next release and merged
it into next/fixes-non-critical.

Thanks to everyone involved getting it to work again!

	Arnd
