From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 8 Nov 2012 13:56:31 -0500 (EST)
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <20121108162613.GB16373@mudshark.cambridge.arm.com>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
 <20121106220458.GP28327@n2100.arm.linux.org.uk>
 <20121107095106.GA23305@mudshark.cambridge.arm.com>
 <20121107095635.GV28327@n2100.arm.linux.org.uk>
 <20121107100835.GB23305@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211071035220.21033@xanadu.home>
 <20121107184129.GB18293@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211071505410.21033@xanadu.home>
 <20121108162613.GB16373@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1211081355070.21033@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2012, Will Deacon wrote:

> I checked all of the switch_mm implementations and it looks like
> !CONFIG_CPU_HAS_ASID implies the TLB flush in all cases, so this looks fine
> to me.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Submitted as patch 7573/1.

Thanks!


Nicolas
