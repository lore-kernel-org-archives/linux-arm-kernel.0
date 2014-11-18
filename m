From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 18 Nov 2014 14:51:42 +0000
Subject: [PATCH v5 6/6] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <20141118093239.46f9b655@gandalf.local.home> (Steven Rostedt's
 message of "Tue, 18 Nov 2014 09:32:39 -0500")
References: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
 <1416310887-14649-7-git-send-email-punit.agrawal@arm.com>
 <20141118093239.46f9b655@gandalf.local.home>
Message-ID: <9hh8uj8v9xd.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 18 Nov 2014 11:41:27 +0000
> Punit Agrawal <punit.agrawal@arm.com> wrote:
>
>> Introduce an event to trace the usage of emulated instructions. The
>> trace event is intended to help identify and encourage the migration
>> of legacy software using the emulation features.
>> 
>> Use this event to trace usage of swp and CP15 barrier emulation.
>> 
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>
> For the tracing side:
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Cheers, Steve.

>
> -- Steve
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
