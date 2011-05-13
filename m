From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 May 2011 15:32:38 +0100
Subject: [PATCH 14/13] clocksource: ARM sp804: allow clocksource name
	to be	specified
In-Reply-To: <20110512134924.GB6098@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<20110512134924.GB6098@n2100.arm.linux.org.uk>
Message-ID: <1305297158.31204.114.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-12 at 14:49 +0100, Russell King - ARM Linux wrote:
> This allows platforms to specify the clocksource name upon
> registration, which is necessary should they wish to register more
> than one sp804 clocksource.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
