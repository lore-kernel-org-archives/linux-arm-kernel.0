From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 03 Dec 2010 13:54:44 -0800
Subject: [PATCH 0/22] More SMP cleanup
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <1291413284.19493.15.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-12-03 at 20:07 +0000, Russell King - ARM Linux wrote:
> This patch series incorporates patches from the previously posted
> "Clean up SMP IPI support" series of 9 patches.  Patch 5, and
> 11 onwards are new.
> 
> This aims to reduce the amount of code in platform specific files
> to the barest minimum, while maintaining the flexibility of the
> API to allow platforms to decide which CPU numbers are populated.

Are you going to queue this for 2.6.38 or a later merge window?

Daniel
-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
