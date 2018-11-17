From: will.deacon@arm.com (Will Deacon)
Date: Sat, 17 Nov 2018 02:27:48 +0000
Subject: [PATCH v2] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181116182130.4327-1-geomatsi@gmail.com>
References: <20181116182130.4327-1-geomatsi@gmail.com>
Message-ID: <20181117022748.GC2470@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 09:21:30PM +0300, Sergey Matyukevich wrote:
> Specify correct type for the constants to avoid
> the following sparse complaints:
> 
> ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---

I still think this is bogus, but the warning is clearly irritating so:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin, can you pick this up please?

Will
