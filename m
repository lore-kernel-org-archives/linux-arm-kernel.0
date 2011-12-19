From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 19 Dec 2011 14:53:29 +0100
Subject: [PATCH v2 03/10] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
In-Reply-To: <20111219120321.GM11800@sortiz-mobl>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-4-git-send-email-b-cousson@ti.com>
 <20111219120321.GM11800@sortiz-mobl>
Message-ID: <4EEF41D9.30101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Samuel,

On 12/19/2011 1:03 PM, Samuel Ortiz wrote:
> Hi Benoit,
>
> On Fri, Dec 09, 2011 at 03:02:34PM +0100, Benoit Cousson wrote:
>> Add initial device-tree support for twl familly chips.
>> The current version is missing the regulator entries due
>> to the lack of DT regulator bindings for the moment.
>> Only the simple sub-modules that do not depend on
>> platform_data information can be initialized properly.
>>
>> Add documentation for the Texas Instruments TWL Integrated Chip.
> Thanks, patch applied.

Thanks,
Benoit
