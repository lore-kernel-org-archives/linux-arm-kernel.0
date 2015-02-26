From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 26 Feb 2015 11:02:31 +0000
Subject: stand-alone kvmtool
In-Reply-To: <54EAFCE9.5030000@arm.com>
References: <54DDD465.3050300@arm.com> <20150218155042.GF22017@arm.com>
 <54EAFCE9.5030000@arm.com>
Message-ID: <87mw41aqbc.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Andre Przywara <andre.przywara@arm.com> writes:

> Hi Will,
>
> On 18/02/15 15:50, Will Deacon wrote:
>> Hi Andre,
>> 
>> Thanks for doing this. Since it looks unlikely that kvmtool will ever be
>> merged back into the kernel tree, it makes sense to cut the dependency
>> in my opinion.
>> 
<snip>
>
> P.S. Although both approaches still provide the kvmtool patch history,
> they do not compile before the dependency cut patches. If that is an
> issue, one could think about injecting those new patches back into the
> repository time line. Admittedly that sounds scary, but would solve the
> problem.

If you can have it all it would be nice to preserve buildability all
through your history for bisecting (and the moon on a stick please ;-)

Is the dependency on the kernel sources something that has been stable
over the projects history or something that's been declining/increasing
over time?

-- 
Alex Benn?e
