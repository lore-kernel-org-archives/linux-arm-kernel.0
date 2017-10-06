From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 6 Oct 2017 20:51:57 +0200
Subject: [PATCH 2/2] firmware: arm_scpi: remove all single element
 structures
In-Reply-To: <e3fd0668-f23b-6da5-ee0c-0ef146ec4d7b@arm.com>
References: <1507201911-27976-1-git-send-email-sudeep.holla@arm.com>
 <1507201911-27976-2-git-send-email-sudeep.holla@arm.com>
 <18e4e7d1-69e8-0176-b823-4de102973ef5@gmail.com>
 <e3fd0668-f23b-6da5-ee0c-0ef146ec4d7b@arm.com>
Message-ID: <92d71b0d-8cb0-7806-5763-880d2abbecb5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.10.2017 um 10:53 schrieb Sudeep Holla:
> 
> 
> On 05/10/17 20:07, Heiner Kallweit wrote:
>> Am 05.10.2017 um 13:11 schrieb Sudeep Holla:
>>> Both clk_get_value and sensor_value structures contains a single element
>>> and hence needs no packing making the whole structure defination
>>> unnecessary.
>>>
>>> This patch gets rid of both those structures
>>>
>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> [..]
> 
>>>
>> Looks good to me.
> 
> Thanks. Tested-by or Reviewed-by would help ;)
> 
> 
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
