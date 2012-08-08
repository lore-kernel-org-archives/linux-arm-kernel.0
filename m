From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 08 Aug 2012 17:35:34 +0300
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <20120808125252.GR16861@opensource.wolfsonmicro.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <5022529D.3090406@ti.com>
 <20120808125252.GR16861@opensource.wolfsonmicro.com>
Message-ID: <50227936.3040701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 03:52 PM, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 01:50:53PM +0200, Benoit Cousson wrote:
> 
>> That being said, since we do have the clock binding now, maybe we should
>> create a clock provider at board level for the sys_clk and thus you will
>> just have to create a phandle to it in your audio description.
> 
> Yes, we should be doing this.

Does this needs the common clock framework on the platform? OMAP3 certainly
does not have it enabled since it has not been adopted.

-- 
P?ter
