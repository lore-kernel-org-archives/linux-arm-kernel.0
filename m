From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 01 Apr 2012 01:38:36 +0400
Subject: [PATCH] ARM: at91: include newly created system_misc.h file
In-Reply-To: <1333110669-24554-1-git-send-email-nicolas.ferre@atmel.com>
References: <cover.1333026637.git.nicolas.ferre@atmel.com>
 <1333110669-24554-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4F77795C.6050109@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 30-03-2012 16:31, Nicolas Ferre wrote:

> system.h file has been split by commit "0195c00".

    Please also specify that commit's summary in parens. And don't put commit 
ID into quoates.

> Now include
> system_misc.h for having access to arm_pm_restart.

> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

WBR, Sergei
