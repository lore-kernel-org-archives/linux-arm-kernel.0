From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 8 Jun 2011 15:12:10 +0200
Subject: [Patch v2 09/11] ARM: perf: add PMUv2 common event definitions
In-Reply-To: <20110608130838.GF3876@e102144-lin.cambridge.arm.com>
References: <1307536233-30089-1-git-send-email-will.deacon@arm.com>
	<1307536233-30089-10-git-send-email-will.deacon@arm.com>
	<BANLkTik-ms3r-+VSAw2vSDGKqO+31xwghw@mail.gmail.com>
	<20110608130838.GF3876@e102144-lin.cambridge.arm.com>
Message-ID: <BANLkTimTPbUU7LFxkevuEm01M0u9PFYHwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 3:08 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jun 08, 2011 at 02:02:41PM +0100, Jean Pihet wrote:
>> Hi Will,
>>
>> On Wed, Jun 8, 2011 at 2:30 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > The PMUv2 specification reserves a number of event encodings
>> > for common events.
>> >
>> > This patch adds these events to the common event enumeration
>> > in preparation for PMUv2 cores, such as Cortex-A15.
>> >
>> > Cc: Jean Pihet <jean.pihet@newoldbits.com>
>> > Signed-off-by: Will Deacon <will.deacon@arm.com>
>>
>> The change looks good, here is the acked-by FWIW:
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Cheers Jean, I'll add your Ack (rather than S-O-B).
Yes sorry about the wrong copy-paste ;p

Thanks,
Jean

>
> Will
>
