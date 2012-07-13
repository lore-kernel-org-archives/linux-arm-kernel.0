From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Fri, 13 Jul 2012 16:51:32 +0530
Subject: [PATCHv11 1/6] i2c: omap: Optimise the remove code
In-Reply-To: <20120712121857.GA2194@pengutronix.de>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-2-git-send-email-shubhrajyoti@ti.com>
 <20120712121857.GA2194@pengutronix.de>
Message-ID: <500004BC.1060403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 July 2012 05:48 PM, Wolfram Sang wrote:
> On Thu, Jun 28, 2012 at 08:41:27PM +0530, Shubhrajyoti D wrote:
>> The omap_i2c_remove function may not be needed after
>> device exit so the memory could be freed.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Changed the title from "optimise" to "annotate" and pushed to next.
Thanks for fixing that.
>
