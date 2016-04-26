From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Tue, 26 Apr 2016 08:22:07 -0500
Subject: [PATCH v6 0/7] ARM: dts: DRA7: Add dt nodes for PWMSS
In-Reply-To: <alpine.DEB.2.02.1604251610170.22464@utopia.booyaka.com>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
 <alpine.DEB.2.02.1604251610170.22464@utopia.booyaka.com>
Message-ID: <571F6B7F.8090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/25/2016 11:18 AM, Paul Walmsley wrote:
> On Fri, 22 Apr 2016, Franklin S Cooper Jr wrote:
> 
>> This patch series adds support for PWM for DRA7. The IP is the same as the
>> one present in AM33XX and AM437XX.
>>
>> However, before doing so remove unnecessary hwmod entries for eCAP, ePWM
>> and eQEP.
> 
> Just took a quick look (nothing indepth).  Looks OK.  
> 
> Once Rob's issues have been addressed, please feel free to add an 
> Acked-by: from me.  Thanks for playing along, Franklin, I think this final 
> product makes the most sense from a device architecture point of view.


Thanks Paul. Just to be clear I can add your Acked-by to all 7 patches?
> 
> 
> - Paul
> 
