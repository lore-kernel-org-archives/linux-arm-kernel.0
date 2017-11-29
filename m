From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 29 Nov 2017 15:49:26 -0500
Subject: [PATCH V3 2/4] ACPI / bus: introduce acpi_device_get_match_data()
 function
In-Reply-To: <20171129135536.GD32417@localhost>
References: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
 <1510281175-27173-2-git-send-email-okaya@codeaurora.org>
 <31ef1ea5-ddb6-1a24-980b-7986627cfeca@codeaurora.org>
 <1605519.pfaIp4IsxJ@aspire.rjw.lan> <20171129135536.GD32417@localhost>
Message-ID: <7a89f75e-d740-9252-419a-58a7b26b0df2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2017 8:55 AM, Vinod Koul wrote:
>> While I understand that the name follows the OF convention, I have some
>> doubts on whether it is the best one.
> Perhpas acpi_get_match_data() ?

Will change as recommended unless Rafael has a better idea.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
