From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 29 Oct 2014 14:26:20 +0000
Subject: [PATCHv3 1/5] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <1414435207-30240-3-git-send-email-punit.agrawal@arm.com> (Punit
 Agrawal's message of "Mon, 27 Oct 2014 18:40:03 +0000")
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-3-git-send-email-punit.agrawal@arm.com>
Message-ID: <9hhvbn3eyur.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Punit Agrawal <punit.agrawal@arm.com> writes:

> Add support to register hooks for undefined instructions. The handlers
> will be called when the undefined instruction and the processor state
> (as contained in pstate) match criteria used at registration.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  arch/arm64/include/asm/insn.h  |  2 ++
>  arch/arm64/include/asm/traps.h | 16 ++++++++++
>  arch/arm64/kernel/insn.c       |  5 ++++
>  arch/arm64/kernel/traps.c      | 68 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 91 insertions(+)
>

This patch was sent twice by mistake. Please ignore this copy.

[...]
