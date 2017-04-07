From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 7 Apr 2017 09:09:36 -0400
Subject: [PATCH V7 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B2846676309A@IRSMSX101.ger.corp.intel.com>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
 <7c48ca8b-b834-3257-91dc-77e9d19def6c@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466761383@IRSMSX101.ger.corp.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B2846676271D@IRSMSX101.ger.corp.intel.com>
 <951505b8-9580-7131-2f14-de92817190a7@codeaurora.org>
 <CACK8Z6FG7QHs1kQUoTJTcP3606+xBLFp9RUmLuv0m0X2mxH9XA@mail.gmail.com>
 <92EBB4272BF81E4089A7126EC1E7B2846676309A@IRSMSX101.ger.corp.intel.com>
Message-ID: <896488eb-cb1d-03b9-73a0-011e4a9025c5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/7/2017 5:03 AM, Patel, Mayurkumar wrote:
> So basically, I am not currently 100% sure, what is the proper fix for this. Whether BIOS should
> enable L1SS on Root Port no matter Endpoint is connected or not during boot?

I'd like to force the kernel to reconfigure ASPM for all combinations
when there is no card attached during boot and we do a hotplug insertion. 

I'm thinking about how to do this now.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
