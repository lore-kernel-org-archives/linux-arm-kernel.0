From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Thu, 11 Jun 2015 15:12:43 +0100
Subject: [PATCH] arm64: dts: add device tree for ARM SMM-A53x2 on LogicTile
 Express 20MG
In-Reply-To: <20150610085825.GS12807@e106497-lin.cambridge.arm.com>
References: <1433864311-2326-1-git-send-email-kristina.martsenko@arm.com>
 <20150610085825.GS12807@e106497-lin.cambridge.arm.com>
Message-ID: <5579975B.8080902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 10/06/15 09:58, Liviu Dudau wrote:
> Hi Kristina,
> 
> On Tue, Jun 09, 2015 at 04:38:31PM +0100, Kristina Martsenko wrote:
>> Add a DTS file for the MP2 Cortex-A53 Soft Macrocell Model implemented
>> on a LogicTile Express 20MG (V2F-1XV7) daughterboard. This is based on
>> the version that's currently available from the ARM DTS repository [1].
>>
>> [1] git://linux-arm.org/arm-dts.git
> 
> I thought the plan was to keep new DTs in this repository, not to add
> them into the kernel. Has this changed?

There doesn't seem to be a plan, and all new DTs are being merged into
the kernel. So for the time being it's better to have this one in the
kernel as well.

Thanks for the review, I'll send a v2.

Kristina
