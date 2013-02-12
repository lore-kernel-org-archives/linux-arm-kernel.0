From: rogerq@ti.com (Roger Quadros)
Date: Tue, 12 Feb 2013 09:47:40 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Allow clock alias provision from device
 tree
In-Reply-To: <20130211160752.GG1906@pengutronix.de>
References: <1360597464-8491-1-git-send-email-rogerq@ti.com>
 <20130211160752.GG1906@pengutronix.de>
Message-ID: <5119F39C.2080206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 06:07 PM, Sascha Hauer wrote:
> On Mon, Feb 11, 2013 at 05:44:23PM +0200, Roger Quadros wrote:
>> Currently on OMAP, it is not possible to specify a clock consumer
>> to any of the OMAP generated clocks using the device tree. This can pose
>> a problem for external devices that run off an OMAP clock as we
>> can't reliably provide a reference to the clock in the device tree.
> 
> There is an established way of providing clocks in the devicetree using
> the clocks/clock-names properties. Wouldn't it be better using this
> for OMAP aswell?
> 
I agree with you, but I'm not sure when this migration will be done.
Rajendra/Santosh might know better.

regards,
-roger
