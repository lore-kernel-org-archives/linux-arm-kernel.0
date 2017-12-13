From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 12 Dec 2017 19:09:47 -0500
Subject: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
In-Reply-To: <CAJZ5v0ijQFO_PuwhBRrKovo4EW9Dck9fiT38wiCw6P5hHUjNuw@mail.gmail.com>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
 <20171212053845.GB18649@localhost>
 <CAJZ5v0ijQFO_PuwhBRrKovo4EW9Dck9fiT38wiCw6P5hHUjNuw@mail.gmail.com>
Message-ID: <0ed35958-22c9-50e5-3b6a-732821de6d20@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2017 7:36 AM, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2017 at 6:38 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> On Thu, Dec 07, 2017 at 04:10:24PM -0500, Sinan Kaya wrote:
>>> Introduce new ACPI and OF device ids for thw HW along with the helper
>>> functions.
>>>
>>> Changes from v6:
>>> * add const to the device callback parameter in fwnode.
>>> * reorganize the callbacks in the code
>>> * rename get_match_data() as device_get_match_data()
>>> * place pointer checks into acpi_get_match_data()
>>
>> This fails for me at 3rd patch. I am on -rc1 is there a dependency?
> 
> There shouldn't be any.
> 
> According to git, all changes to the files touched by the [3/7] are in
> -rc1 already.
> 

Let me know if you were able to resolve the conflict. I can rebase against
a development tree if you can point me to there.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
