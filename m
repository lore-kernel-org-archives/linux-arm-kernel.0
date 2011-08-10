From: tixy@yxit.co.uk (Tixy)
Date: Wed, 10 Aug 2011 12:43:56 +0100
Subject: [RFC PATCH 3/5] ARM: kprobes: Reference cpu_architecture as a
	global variable
In-Reply-To: <1312971223-28165-4-git-send-email-dave.martin@linaro.org>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
	<1312971223-28165-4-git-send-email-dave.martin@linaro.org>
Message-ID: <1312976636.7800.32.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-10 at 11:13 +0100, Dave Martin wrote:
> This patch is needed for compatibility with the change of
> cpu_architecture from a function to a global variable.
> 
> Since cpu_architecture is ARM-specific, also add an explicit
> include for <asm/system.h> rather than relying on this being
> included as a side-effect.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/kernel/kprobes-common.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)

Is there any reason that this patch isn't part of the other ARM platform
changes in patch one?

-- 
Tixy
