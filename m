From: nm@ti.com (Nishanth Menon)
Date: Tue, 08 Mar 2011 08:19:31 +0530
Subject: [PATCH V2 0/3]: OMAP4: Update OPP Table and Voltage Rail Values
In-Reply-To: <87vczuzhqj.fsf@ti.com>
References: <1299318621-21280-1-git-send-email-shweta.gulati@ti.com>
	<87vczuzhqj.fsf@ti.com>
Message-ID: <4D75993B.1090606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote, on 03/08/2011 04:00 AM:
> Shweta Gulati<shweta.gulati@ti.com>  writes:
>
>> The Series Updates OPP Table for MPU, add OPP enteries
>> for IVA and update Voltage Rail values for MPU/IVA.
>>
>> It is based on the Patch which replaces
>> Voltage values with Macros, Submitted by
>> Nishanth Menon
>> https://patchwork.kernel.org/patch/607541/
>>
>> Branch: pm-core
>>
>> Tested on OMAP4430 SDP.
>>
>> V2:
>> Rebased on pm-core and incorporated
>> comments from Nishanth Menon.
>
> This version looks OK to me.
>
> Will queue for 2.6.39 after I see an Ack from Nishanth.

I have Acked the series.

unrelated to this series, as commented in:
http://marc.info/?l=linux-omap&m=129955003611548&w=2

I had initially considered the option of rounding the DM values to 
TWL6030 step size, then realized that there are TPS chips with 25mV and 
custom PMICs with step sizes of 10mV. we probably need a solution for 
.40 merge window where the PMIC variances (as brought out by Sanjeev as 
well in http://marc.info/?t=129848405600010&r=1&w=2 and elsewhere), are 
handled transparently. This ofcourse is not related to the current series.

-- 
Regards,
Nishanth Menon
