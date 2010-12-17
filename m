From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 17 Dec 2010 14:01:35 +0100
Subject: [PATCH 01/40] ARM: AT91: update clock source registration
In-Reply-To: <E1PTYb5-0006hh-Di@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYb5-0006hh-Di@rmk-PC.arm.linux.org.uk>
Message-ID: <20101217130135.GB19897@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:35 Fri 17 Dec     , Russell King - ARM Linux wrote:
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

I'll test it monday

Best Regards,
J.
