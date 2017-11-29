From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 29 Nov 2017 17:14:35 -0500
Subject: [PATCH V3 3/4] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <20171129135813.GE32417@localhost>
References: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
 <1510281175-27173-3-git-send-email-okaya@codeaurora.org>
 <20171129135813.GE32417@localhost>
Message-ID: <dd656bd9-2e70-931b-62d7-f2c5b68d1892@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+linux-acpi

On 11/29/2017 8:58 AM, Vinod Koul wrote:
>> +		cap = (enum hidma_cap) acpi_device_get_match_data(dev);
> should this not reside in core? How about a device_get_match_data() which
> returns the data for folks based on node being acpi/of

Sure,

I'm preparing a device function to read this as you suggested.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
