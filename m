From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 14 Dec 2010 12:32:14 -0800
Subject: [PATCH 08/24] ARM: MSM: update clock source registration
In-Reply-To: <E1PSDu2-0008Co-0D@rmk-PC.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDu2-0008Co-0D@rmk-PC.arm.linux.org.uk>
Message-ID: <4D07D44E.4090805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants.  Switch over to using this new interface.
>
>   
Tested-By: Jeff Ohlstein <johlstei@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
