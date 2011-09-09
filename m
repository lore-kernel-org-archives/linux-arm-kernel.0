From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 09 Sep 2011 09:52:30 +0530
Subject: [PATCH 11/25] OMAP: Add Secure HAL and monitor mode API
	infrastructure.
In-Reply-To: <CAORVsuX5ovK2X8cMGijywAAhOB+ymDze1SzgzVWV2hnZYcswAQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-12-git-send-email-santosh.shilimkar@ti.com>
	<CAORVsuX5ovK2X8cMGijywAAhOB+ymDze1SzgzVWV2hnZYcswAQ@mail.gmail.com>
Message-ID: <4E699486.2080504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011 12:28 AM, Jean Pihet wrote:
> Santosh,
>
> On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On OMAP secure/emulation devices, certain APIs are exported by secure
>> code. Add an infrastructure so that relevant operations on secure
>> devices can be implemented using it.
>>
>> While at this, omap44xx-smc.S to omap-smc.S since the common APIs
>> can be used on other OMAP's too.
> 'move' or 'rename' is missing in the sentence.
>
Yep. Will fix it.

Regards
Santosh
