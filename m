From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 16 Nov 2010 09:29:52 +0100
Subject: [PATCH 4/5] ARM: perf: encode PMU name in arm_pmu structure
In-Reply-To: <20101115190335.GC2764@pulham.picochip.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<1289842263-21241-5-git-send-email-will.deacon@arm.com>
	<20101115190335.GC2764@pulham.picochip.com>
Message-ID: <AANLkTin1KBF-npitEoJ-3Ry-Ea2JGVyY_CfME+9SZL9i@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 8:03 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> On Mon, Nov 15, 2010 at 05:31:02PM +0000, Will Deacon wrote:
>> Currently, perf uses the PMU ID as an index into a string table
>> to look up the name of a given PMU.
>>
>> This patch encodes the name of a PMU directly into the arm_pmu
>> structure so that PMU-specific code can be factored out into
>> separate files.
>>
>> Cc: Jamie Iles <jamie.iles@picochip.com>
>> Cc: Jean Pihet <jean.pihet@newoldbits.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> ---
> Looks good.
>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
>

Nice, thanks!

Acked-by: Jean Pihet <j-pihet@ti.com>
