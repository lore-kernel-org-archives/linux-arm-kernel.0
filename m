From: davidb@codeaurora.org (David Brown)
Date: Fri, 17 Dec 2010 13:23:14 -0800
Subject: [PATCH 08/40] ARM: MSM: update clock source registration
In-Reply-To: <E1PTYdO-0006i9-8H@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYdO-0006i9-8H@rmk-PC.arm.linux.org.uk>
Message-ID: <20101217212313.GA7108@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 11:38:02AM +0000, Russell King - ARM Linux wrote:

> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Tested-By: Jeff Ohlstein <johlstei@codeaurora.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
