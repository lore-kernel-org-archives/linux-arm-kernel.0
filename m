From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 13 Dec 2013 15:25:50 +0530
Subject: [PATCH v5 1/9] phy: add phy_get_bus_width()/phy_set_bus_width()
 calls
In-Reply-To: <20131212181818.GI1939@saruman.home>
References: <1386854770-2173-1-git-send-email-mporter@linaro.org>
 <1386854770-2173-2-git-send-email-mporter@linaro.org>
 <20131212181818.GI1939@saruman.home>
Message-ID: <52AAD9A6.40907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013 11:48 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Dec 12, 2013 at 08:26:02AM -0500, Matt Porter wrote:
>> This adds a pair of APIs that allows the generic PHY subsystem to
>> provide information on the PHY bus width. The PHY provider driver may
>> use phy_set_bus_width() to set the bus width that the PHY supports.
>> The controller driver may then use phy_get_bus_width() to fetch the
>> PHY bus width in order to properly configure the controller.
>>
>> Signed-off-by: Matt Porter <mporter@linaro.org>
> 
> Kishon, I need your Acked-by here, if you're ok with the change.

here it goes..
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
