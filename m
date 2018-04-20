From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Apr 2018 15:00:39 +0200
Subject: [PATCH 4/8] clk: mediatek: mt2701-mm: switch to mfd device
In-Reply-To: <20171115001705.GJ11955@codeaurora.org>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-5-mbrugger@suse.com>
 <20171115001705.GJ11955@codeaurora.org>
Message-ID: <e41d07ff-5870-1ec5-18fc-d89538529a8f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 11/15/2017 01:17 AM, Stephen Boyd wrote:
> On 11/14, Matthias Brugger wrote:
>> As the new mfd device is in place, switch probing
>> for the MMSYS to support invocation from the mfd device.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 

I did a minor change to this patch and patch 7/8 to get rid of mmsys_private
variable. Nevertheless I kept your Acked-by, as it only changes how we get the
device tree node.

Hope that's OK with you.

Regards,
Matthias
