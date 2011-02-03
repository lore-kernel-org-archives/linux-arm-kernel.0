From: smuckle@codeaurora.org (Steve Muckle)
Date: Wed, 02 Feb 2011 18:05:46 -0800
Subject: barriers in mutexes?
Message-ID: <4D4A0D7A.9090005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Looking at kernel/mutex.c and arch/arm/include/asm/mutex.h, it appears
there aren't any memory barriers in the fast path of mutexes. I see this
was discussed here a long time back:

http://patchwork.kernel.org/patch/25856/

How was this resolved?

thanks,
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
