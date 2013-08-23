From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 23 Aug 2013 11:54:45 -0400
Subject: [PATCH v4 3/5] net: ethernet: cpsw: introduce ti,am3352-cpsw
 compatible string
In-Reply-To: <52177E29.6040103@baylibre.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-4-git-send-email-zonque@gmail.com>
 <52177052.1030308@ti.com> <52177E29.6040103@baylibre.com>
Message-ID: <521785C5.9000903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 August 2013 11:22 AM, Benoit Cousson wrote:
> Hi Santosh,
> 
> [...]
> 
>>> +static const struct of_device_id cpsw_of_mtable[] = {
>>> +    {
>>> +        .compatible    = "ti,am3352-cpsw",
>> I didn't notice this earlier, but can't you use the IP version
>> as a compatible instead of using a SOC name. Whats really SOC specific
>> on this IP ? Sorry i have missed any earlier discussion on this but
>> this approach doesn't seem good. Its like adding SOC checks in the
>> driver subsystem.
> 
> Hehe, welcome to the club!
> I keep arguing about that as well :-)
> 
> I think we should create a Facebook group: "against-the-soc-version-in-the-compatible-string".
> 
Indeed !!

Regards,
Santosh
