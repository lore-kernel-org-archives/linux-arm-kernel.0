From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 12 Dec 2017 13:36:01 +0100
Subject: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
In-Reply-To: <20171212053845.GB18649@localhost>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
 <20171212053845.GB18649@localhost>
Message-ID: <CAJZ5v0ijQFO_PuwhBRrKovo4EW9Dck9fiT38wiCw6P5hHUjNuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 6:38 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Dec 07, 2017 at 04:10:24PM -0500, Sinan Kaya wrote:
>> Introduce new ACPI and OF device ids for thw HW along with the helper
>> functions.
>>
>> Changes from v6:
>> * add const to the device callback parameter in fwnode.
>> * reorganize the callbacks in the code
>> * rename get_match_data() as device_get_match_data()
>> * place pointer checks into acpi_get_match_data()
>
> This fails for me at 3rd patch. I am on -rc1 is there a dependency?

There shouldn't be any.

According to git, all changes to the files touched by the [3/7] are in
-rc1 already.
