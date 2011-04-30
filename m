From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Apr 2011 22:58:33 -0700
Subject: Resend [PATCH 00/10] ARM: SMP initialization consolidation
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <4DBBA509.6080203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2011 07:08 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Resending since the patches didn't make it thru the 1st time.
>
> In order to avoid duplicating the same platform code yet again for a new 
> platform, this series consolidates platforms using similar SMP startup code to
> a common implementation. A new kconfig entry SMP_COMMON_PEN is added for
> platforms using the common pen functions.
>
> OMAP uses a h/w mechansism for its pen, but it seems like it could use the same
> mechansism.

Have you seen Russell's response to similar attempts posted a few months
back?

https://lkml.org/lkml/2010/11/30/243

and

http://lists.linaro.org/pipermail/linaro-dev/2010-November/001663.html

Just something to look over and consider.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
