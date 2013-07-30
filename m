From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 30 Jul 2013 10:46:01 +0530
Subject: [PATCH 2/4] serial: omap: enable PM runtime only when its fully
 configured
In-Reply-To: <51F62CEB.2090502@ti.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com>
 <1374487277-26099-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.02.1307290843090.30864@utopia.booyaka.com>
 <51F62CEB.2090502@ti.com>
Message-ID: <51F74C11.2000306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 July 2013 02:20 PM, Rajendra Nayak wrote:
> On Monday 29 July 2013 02:14 PM, Paul Walmsley wrote:
>> Rajendra,
>>
>> On Mon, 22 Jul 2013, Rajendra Nayak wrote:
>>
>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>>
>>> If earlyprintk is enabled and current UART is console port the platform
>>> code can mark it as RPM_ACTIVE to sync real IP state with PM Runtime and
>>> avoid resuming of already active device, but now, driver initialization
>>> will be performed in the wrong way:
>>
>> ...
>>
>>> CC: Tony Lindgren <tony@atomide.com>
>>> CC: Rajendra Nayak <rnayak@ti.com>
>>> CC: Felipe Balbi <balbi@ti.com>
>>> CC: Kevin Hilman <khilman@linaro.org>
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Did you intend to add your Signed-off-by: to this patch?  Since you're 
>> formally submitting it, it needs to have your Signed-off-by: for me to 
>> take it.  Let me know and I'll add it if needed -
> 
> Sorry about that Paul. I indeed missed adding my SoB for this one.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Paul,

Looks like this one is already been queued by Greg.

regards,
Rajendra

> 
>>
>> - Paul
>>
> 
