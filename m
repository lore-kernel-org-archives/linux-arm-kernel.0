From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 18 Nov 2014 09:32:39 -0500
Subject: [PATCH v5 6/6] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <1416310887-14649-7-git-send-email-punit.agrawal@arm.com>
References: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
 <1416310887-14649-7-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141118093239.46f9b655@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Nov 2014 11:41:27 +0000
Punit Agrawal <punit.agrawal@arm.com> wrote:

> Introduce an event to trace the usage of emulated instructions. The
> trace event is intended to help identify and encourage the migration
> of legacy software using the emulation features.
> 
> Use this event to trace usage of swp and CP15 barrier emulation.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---

For the tracing side:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
