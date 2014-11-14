From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Nov 2014 18:33:48 +0000
Subject: [PATCHv4 5/5] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <1415792692-11189-6-git-send-email-punit.agrawal@arm.com>
References: <1415792692-11189-1-git-send-email-punit.agrawal@arm.com>
 <1415792692-11189-6-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141114183348.GG6755@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 11:44:52AM +0000, Punit Agrawal wrote:
> Introduce an event to trace the usage of emulated instructions. The
> trace event is intended to help identify and encourage the migration
> of legacy software using the emulation features.
> 
> Use this event to trace usage of swp and CP15 barrier emulation.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

I can't comment much on trace stuff but I'm ok with the patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
