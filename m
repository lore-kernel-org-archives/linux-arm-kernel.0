From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 5 Oct 2016 08:58:27 +0530
Subject: [PATCH v2 2/4] net: phy: dp83867: add support for MAC impedance
 configuration
In-Reply-To: <20161004131032.GL11677@lunn.ch>
References: <20161004125607.10569-1-mugunthanvnm@ti.com>
 <20161004125607.10569-3-mugunthanvnm@ti.com> <20161004131032.GL11677@lunn.ch>
Message-ID: <20264692-6a13-58c0-c262-f631af8f355e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 October 2016 06:40 PM, Andrew Lunn wrote:
>> +	if (of_property_read_bool(of_node, "ti,max-output-imepdance"))
>> +		dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX;
>> +	else if (of_property_read_bool(of_node, "ti,min-output-imepdance"))
> 
> Did you really test this? Or did you make the same typos in your device
> tree file?
> 

I have tested this and attached the log in cover letter. Since there is
a typo error on both dts and driver it worked as expected. Will send a
v3 ASAP.

Regards
Mugunthan V N
