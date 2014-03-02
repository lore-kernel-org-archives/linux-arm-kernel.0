From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 02 Mar 2014 21:47:56 +0100
Subject: [PATCH v2 5/5] phy: mvebu-sata: prepare new Dove DT Kconfig
 variable
In-Reply-To: <5311E2EB.70301@ti.com>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <5311E2EB.70301@ti.com>
Message-ID: <531398FC.6020405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2014 02:38 PM, Kishon Vijay Abraham I wrote:
> On Saturday 01 March 2014 02:03 PM, Sebastian Hesselbarth wrote:
>> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to
>> MACH_DOVE in
>> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
>> DT-only MACH_DOVE Kconfig.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>> Kishon,
>>
>> Mark Brown requested to take the corresponding ASoC patch through
>> his tree. Therefore, I have split the former patch into individual
>> subsystem
>> patches. This patch also received an update, to not break bisectability
>> we add DT-enabled MACH_DOVE and maintain ARCH_DOVE, which is non-DT only
>> after conversion. ARCH_DOVE will be removed, when legacy mach-dove will
>> be removed.
>
> Cool.. Should this patch be going through PHY tree?

Yes, please pick it up.

Thanks,
   Sebastian
