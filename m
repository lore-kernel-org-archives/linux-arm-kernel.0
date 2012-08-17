From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Aug 2012 20:53:05 -0500
Subject: [PATCH v3 2/3] PM / OPP: Initialize OPP table from device tree
In-Reply-To: <20120817005210.GD24242@S2101-09.ap.freescale.net>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-3-git-send-email-shawn.guo@linaro.org>
 <201208162305.55114.rjw@sisk.pl>
 <20120817005210.GD24242@S2101-09.ap.freescale.net>
Message-ID: <502DA401.7040408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2012 07:52 PM, Shawn Guo wrote:
> On Thu, Aug 16, 2012 at 11:05:54PM +0200, Rafael J. Wysocki wrote:
>> On Friday, August 10, 2012, Shawn Guo wrote:
>>> With a lot of devices booting from device tree nowadays, it requires
>>> that OPP table can be initialized from device tree.  The patch adds
>>> a helper function of_init_opp_table together with a binding doc for
>>> that purpose.
>>>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> I need an ACK from whoever maintains the DT bindings for that.
>>
> Rob, please?

Acked-by: Rob Herring <rob.herring@calxeda.com>
