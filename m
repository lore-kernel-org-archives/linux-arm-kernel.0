From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Nov 2014 18:04:19 +0000
Subject: [PATCH RFC 2/3] ARM: enable TTBR0/TTBR1 split in short mode
In-Reply-To: <20141118165319.9958.67009.stgit@buzz>
References: <20141118165313.9958.1242.stgit@buzz>
 <20141118165319.9958.67009.stgit@buzz>
Message-ID: <20141118180418.GN28279@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 03:53:19PM +0000, Konstantin Khlebnikov wrote:
> This feature was partially implemented long time ago. All cpus load
> swapper_pg_dir into TTBR1 since commit d427958a46af24f75d0017c45eadd172273bbf33
> ("ARM: 6942/1: mm: make TTBR1 always point to swapper_pg_dir on ARMv6/7").
> But TTBRx split is never been enabled in TTBCR.

I recall there is an erratum on Cortex-A9 around the use of TTBR1 and at
the time that stopped me from pushing such change.

-- 
Catalin
