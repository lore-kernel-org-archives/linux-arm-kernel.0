From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 7 May 2010 01:37:26 +0100
Subject: Acer n35 patches
In-Reply-To: <4BE2C688.2070209@vscht.cz>
References: <20100506012258.GZ6684@trinity.fluff.org>
	<4BE2C18E.6080207@vscht.cz> <4BE2C1D7.4030408@vscht.cz>
	<4BE2C224.7080907@vscht.cz> <4BE2C24C.9050008@vscht.cz>
	<4BE2C26E.2080508@vscht.cz> <4BE2C294.7030300@vscht.cz>
	<4BE2C2CC.2010003@vscht.cz> <4BE2C2FF.8020404@vscht.cz>
	<4BE2C688.2070209@vscht.cz>
Message-ID: <20100507003726.GW2589@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 03:39:20PM +0200, Pinkava J. wrote:
> All chenges are taken against 2.6.34-r6 kernel

2.6.34-rc6 should still have working gpio_set_value/gpio_direction_output
calls in it, please update patch 8 to at-least use these.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
