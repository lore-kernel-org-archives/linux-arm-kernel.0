From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 13:07:54 +0100
Subject: [PATCH] arm64: Get rid of struct cpu_table
In-Reply-To: <1426248133-20032-1-git-send-email-marc.zyngier@arm.com>
References: <1426248133-20032-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <2303080.yzVlDbrkJu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 12:02:13 Marc Zyngier wrote:
> struct cpu_table is an artifact left from the (very) early days of
> the arm64 port, and its only real use is to allow the most beautiful
> "AArch64 Processor" string to be displayed at boot time.
> 
> Really? Yes, really.
> 
> Let's get rid of it. In order to avoid another BogoMips-gate, the
> aforementioned string is preserved.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 

Nice catch!

	Arnd
