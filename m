From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:21:41 +0100
Subject: [PATCH 6/7] ARM: enable ARM errata 643719 workaround by default
In-Reply-To: <E1YdzFK-0008Cz-SY@rmk-PC.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <E1YdzFK-0008Cz-SY@rmk-PC.arm.linux.org.uk>
Message-ID: <20150409172141.GK23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 11:54:42AM +0100, Russell King wrote:
> The effects of not having ARM errata 643719 enabled on affected CPUs
> can be very confusing and hard to debug.  Rather than leave this to
> chance, enable this workaround by default.  Now that we have rearranged
> the code, it should have a low impact on the majority of CPUs.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
