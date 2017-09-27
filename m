From: douly.fnst@cn.fujitsu.com (Dou Liyang)
Date: Wed, 27 Sep 2017 15:33:54 +0800
Subject: [PATCH v9] ACPI / init: Invoke early ACPI initialization earlier
In-Reply-To: <alpine.DEB.2.20.1709270917590.1945@nanos>
References: <1505293975-26005-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1505294274-441-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <e4eadcbc-fe58-2d2c-818d-34e2f545db16@cn.fujitsu.com>
 <alpine.DEB.2.20.1709270917590.1945@nanos>
Message-ID: <88ed94a1-83bb-0338-caaa-e1773812ce4a@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

At 09/27/2017 03:19 PM, Thomas Gleixner wrote:
> On Wed, 27 Sep 2017, Dou Liyang wrote:
>
>> Hi Rafael, Zheng,
>>
>> Welcome any comments!
>>
>> Now, our patches are in tip tree, they are based on this
>> independent patch, we hope it can be merged earlier than our
>> patches to avoid ACPI Error. we need your advice and confirmation.
>
> You should have included that patch into your APIC series so I would have
> been aware that it's required for the APIC changes to work on all
> platforms.
>
> But not a big problem. I merge it through tip/x86/apic so the stuff works
> as expected.
>

Yeah, thank you so much.

Thanks,

	dou.
