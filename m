From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Nov 2012 14:04:28 -0700
Subject: [PATCH] ARM: delete struct sys_timer
In-Reply-To: <1352408516-21988-2-git-send-email-swarren@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <509C1E5C.3060306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2012 02:01 PM, Stephen Warren wrote:
> Now that the only field in struct sys_timer is .init, delete the struct,
> and replace the machine descriptor .timer field with the initialization
> function itself.

Oops. This one patch is a duplicate of 11/11 in the series I just sent.
Sorry.
