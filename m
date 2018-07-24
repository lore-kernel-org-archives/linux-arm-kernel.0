From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Jul 2018 11:47:44 +0530
Subject: [PATCH] i2c: davinci: Avoid zero value of CLKH
In-Reply-To: <20180723180722.7b46aw56oqxrwxwj@ninjato>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
 <20180723180722.7b46aw56oqxrwxwj@ninjato>
Message-ID: <8429ab76-28ef-eb82-2448-a0a50bd860ba@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 July 2018 11:37 PM, Wolfram Sang wrote:
> On Fri, Jul 13, 2018 at 05:20:17PM +0200, Alexander Sverdlin wrote:
>> If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
>> and stretch the clock in this case.
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Applied to for-current, thanks!
> 
> I did not add stable because Alexander told me this is very likely not
> to be observed on HW out there. But TI people are investigating more.
> I suggest they resend this patch to stable if they see fit. D'accord
> everyone?

Sounds good to me.

Thanks,
Sekhar
