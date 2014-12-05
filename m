From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Dec 2014 17:38:39 +0000
Subject: using DMA-API on ARM
In-Reply-To: <20141205111114.GQ11285@n2100.arm.linux.org.uk>
References: <5481794E.4050406@broadcom.com> <4565667.WCBuNmaazQ@wuerfel>
 <20141205111114.GQ11285@n2100.arm.linux.org.uk>
Message-ID: <20141205173839.GB31222@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 11:11:14AM +0000, Russell King - ARM Linux wrote:
> In any case, wouldn't using a u64 type for "address" be better - isn't
> "long long" 128-bit on 64-bit architectures?

No, it's still 64-bit. There is no 128-bit integer in the C standard.

-- 
Catalin
