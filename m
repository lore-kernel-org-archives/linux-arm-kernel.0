From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 02 Jul 2012 16:46:21 +0530
Subject: [PATCH 07/29] mfd: omap-usb: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <20120702111850.GC22065@sortiz-mobl>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-8-git-send-email-rnayak@ti.com>
 <20120702111850.GC22065@sortiz-mobl>
Message-ID: <4FF18305.2020301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Monday 02 July 2012 04:48 PM, Samuel Ortiz wrote:
> Hi Rajendra,
>
> On Thu, Jun 14, 2012 at 06:16:56PM +0530, Rajendra Nayak wrote:
>> As we move to Common clk framework use clk_prepare_enable()
>> instead of clk_enable() and similarly clk_disable_unprepare()
>> instead of clk_disable()
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Samuel Ortiz<sameo@linux.intel.com>
>> ---
>>   drivers/mfd/omap-usb-host.c |   28 ++++++++++++++--------------
>>   1 files changed, 14 insertions(+), 14 deletions(-)
> Patch applied, many thanks.

Sorry, I was asked to base these changes on top of work done by
Keshava [1], to split the driver, which is still under review/not
pulled.
I am waiting for those to settle to repost these changes.
Can you please drop this one for now?
Sorry for the confusion.

regards,
Rajendra

[1] http://permalink.gmane.org/gmane.linux.ports.arm.omap/79306

>
> Cheers,
> Samuel.
>
