From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 17 Aug 2011 15:31:21 +0400
Subject: [PATCH 1/3] ARM: Make cpu_alignment into a global variable
In-Reply-To: <1313504053-27873-2-git-send-email-dave.martin@linaro.org>
References: <1313504053-27873-1-git-send-email-dave.martin@linaro.org>
	<1313504053-27873-2-git-send-email-dave.martin@linaro.org>
Message-ID: <4E4BA689.5010100@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 16-08-2011 18:14, Dave Martin wrote:

> The CPU architecture really should not be changing at runtime, so
> make it a global variable instead of a function.

> The cpu_architecture() function in<asm/system.h>  remains the
> correct way to read this variable from C code.

> Signed-off-by: Dave Martin<dave.martin@linaro.org>

    You're talking of the CPU architecture here but the subject has 
"cpu_alignment"...

WBR, Sergei
