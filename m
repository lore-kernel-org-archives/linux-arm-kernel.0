From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 20 Sep 2011 17:07:21 +0530
Subject: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
In-Reply-To: <9fa567d07831a1de1d0700151331b5c7@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<9fa567d07831a1de1d0700151331b5c7@mail.gmail.com>
Message-ID: <4E787AF1.5090400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 September 2011 04:54 PM, Vishwanath Sripathy wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
>> arm-kernel-bounces at lists.infradead.org] On Behalf Of Santosh
>> Shilimkar
>> Sent: Sunday, September 04, 2011 7:24 PM
>> To: linux-omap at vger.kernel.org
>> Cc: khilman at ti.com; Santosh Shilimkar; rnayak at ti.com;
>> linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org
>> Subject: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde
>> support
>>

[...]

>> The series is tested on OMAP4430 SDP for suspend, hotplug and
>> CPUidle
>> with OMAP4 GP and HS (secure) devices.
>>
>> The following changes since commit
>> c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:
>>
>>   Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
>>
>> are available in the git repository at:
>>   git://gitorious.org/omap-sw-develoment/linux-omap-dev.git v3.1-
>> rc4-omap4-mpuss-pm
> I have tested these patch series after adding core retention support  (In
> suspend/resume path)[1] and it worked Fine. I do see that Core and MPU are
> entering CSWR upon suspend and able to wake up via uart.
> 
> You could add tested-by: Vishwanath BS < Vishwanath.bs@ti.com> if you
> want.
> 
Yes I want tested-by and will add your tested-by on the series.
Thanks for testing

Regards
Santosh
