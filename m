From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 7 Mar 2016 22:54:30 -0700
Subject: [PATCH 2/2] ARM: bcm2835: Add devicetree for the Raspberry Pi 3.
In-Reply-To: <1457116769-8567-2-git-send-email-eric@anholt.net>
References: <1457116769-8567-1-git-send-email-eric@anholt.net>
 <1457116769-8567-2-git-send-email-eric@anholt.net>
Message-ID: <56DE6916.9080608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2016 11:39 AM, Eric Anholt wrote:
> For now this doesn't support the new hardware present on the Pi 3 (BT,
> wifi, GPIO expander).  Since the GPIO expander isn't supported, we
> also don't have the LEDs like the other board files do.

The series,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

... although I'd be slightly surprised if this was accepted; when 
AArch64 was first announced, I thought the mainline ARM kernel community 
decided that only 64-bit kernels would be supported on 64-bit HW? Still, 
I don't immediately see that in any commit log or in the kernel doc 
directory, so perhaps I'm misremembering. Hopefully; life is simpler 
that way:-)
