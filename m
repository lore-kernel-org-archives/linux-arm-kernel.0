From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 17 May 2018 09:05:28 -0400
Subject: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
 <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
Message-ID: <6e875491-38a9-f7cf-92d7-53698299403a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/17/2018 6:17 AM, Robin Murphy wrote:
>> +??? }
>> +
> 
> Is this not pretty much just pcibios_bus_to_resource()?
>

Agreed, let me convert the code to use pcibios_bus_to_resource() API.
I wasn't aware of its existence.
 
> Robin.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
