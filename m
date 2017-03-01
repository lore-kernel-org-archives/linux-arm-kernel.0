From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 1 Mar 2017 12:58:08 -0500
Subject: [PATCH V2] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28466668774@IRSMSX101.ger.corp.intel.com>
References: <1485891928-14573-1-git-send-email-okaya@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846666830C@IRSMSX101.ger.corp.intel.com>
 <b78207b6-2c22-3e6d-4837-8b4b396c4f5d@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466668774@IRSMSX101.ger.corp.intel.com>
Message-ID: <f8f67b32-21eb-232b-2b7c-28b603865b9d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 2/28/2017 1:57 PM, Patel, Mayurkumar wrote:
>> I was trying to figure out when to use saved values vs. the values in
>> registers by looking at the enable_cnt.
>> enable_cnt is 0 during boot on my system.
> enable_cnt for the root port on my system is set to 1 for "root port" already without saving
> any ASPM related settings. 
> 
> 

What would be the best way to figure out when to save power-on values from
the registers?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
