From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Nov 2018 12:25:11 +0000
Subject: [PATCH v2] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181116182130.4327-1-geomatsi@gmail.com>
References: <20181116182130.4327-1-geomatsi@gmail.com>
Message-ID: <20181119122510.GD8361@arrakis.emea.arm.com>
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

I queued the patch for 4.20-rc4 and also changed the constant to ~0UL as
per Luc's suggestion. Thanks.

-- 
Catalin
