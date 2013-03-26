From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Mar 2013 11:35:18 +0100
Subject: [PATCH] serial: 8250_dw: add support for clk api
In-Reply-To: <20130321084707.GB2862@xps8300>
References: <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
 <1363690369-8067-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130321084707.GB2862@xps8300>
Message-ID: <515179E6.4020709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Le 21/03/2013 09:47, Heikki Krogerus a ?crit :
> On Tue, Mar 19, 2013 at 11:52:49AM +0100, Maxime Ripard wrote:
>> From: Emilio L?pez <emilio@elopez.com.ar>
>>
>> This commit implements support for using the clk api; this lets us use
>> the "clocks" property with device tree, instead of having to use
>> clock-frequency.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> 
> FWIW,
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Would you consider merging this patch, or do you have additional comments?

We have several patch series that depends on this one that I'd like to
see included in 3.10, and we begin to see the end of the 3.9 release cycle.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
