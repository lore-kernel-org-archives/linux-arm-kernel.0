From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Dec 2011 20:24:41 +0200
Subject: [PATCH v2 8/9] OMAP4: omap4panda: Enable audio support
In-Reply-To: <20111222181518.GM24444@atomide.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
 <1324571902-16918-9-git-send-email-peter.ujfalusi@ti.com>
 <20111222173216.GJ24444@atomide.com> <4EF3721F.8080908@ti.com>
 <20111222181518.GM24444@atomide.com>
Message-ID: <4EF375E9.3060201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2011 08:15 PM, Tony Lindgren wrote:
> OK, sounds good to me. Maybe just make omap4_panda_init_rev() do
> the cpu_is_omap check for now and then you can patch in the dynamic
> detection later on?

Yes, this is exactly what will be done for v3.

>> We can use GPIOs to get the board ID, I'm looking at those for a
>> followup patch.
>> The only issue is that the ID1 GPIO number is different between 4430,
>> and 4460 based Panda.
>> We can have similar revision handling as we have for Beagle at the end.
> 
> OK great.

Thanks,
P?ter
