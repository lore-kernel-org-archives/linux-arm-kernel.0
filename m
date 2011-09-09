From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Sep 2011 14:41:31 -0700
Subject: [PATCH 09/22] OMAP2: add voltage domains and connect to
	powerdomains
In-Reply-To: <CAORVsuXd2eeSs_TFu+stJge6tqQzO+4d0FcnmDPMHnChLgCuiQ@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 12:39:36 +0200")
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-10-git-send-email-khilman@ti.com>
	<CAORVsuXd2eeSs_TFu+stJge6tqQzO+4d0FcnmDPMHnChLgCuiQ@mail.gmail.com>
Message-ID: <87d3f9tmus.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Create basic voltagedomains for OMAP2 and associate OMAP2 powerdomains
>> with the newly created voltage domains.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> ?arch/arm/mach-omap2/Makefile ? ? ? ? ? ? ? ? ?| ? ?3 +-
>> ?arch/arm/mach-omap2/io.c ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +
>> ?arch/arm/mach-omap2/powerdomains2xxx_data.c ? | ? ?4 +++
>> ?arch/arm/mach-omap2/voltage.h ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-omap2/voltagedomains2xxx_data.c | ? 32 +++++++++++++++++++++++++
>> ?5 files changed, 41 insertions(+), 1 deletions(-)
>> ?create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
>>
> ...
>
>> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
>> new file mode 100644
>> index 0000000..69ff261
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
>> @@ -0,0 +1,32 @@
>> +/*
>> + * OMAP3 voltage domain data
>> + *
>> + * Copyright (C) 2007, 2010 Texas Instruments, Inc.
> 2011?
>

Yup, thanks for the review!

Will update.

Kevin
