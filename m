From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 06 Jun 2012 10:38:42 +0530
Subject: Supporting non-device tree consumers with device tree regulator
 drivers
In-Reply-To: <4FCE30D6.7060102@codeaurora.org>
References: <4FCE30D6.7060102@codeaurora.org>
Message-ID: <4FCEE5DA.7090403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 June 2012 09:46 PM, David Collins wrote:
> In the long term, this problem should go away of its own accord.  However,
> in the short term, many systems are converting over to using device tree.
>   Therefore, we are left with a situation currently where some regulator
> consumer drivers are being probed via device tree and some are being
> probed via board file devices within a single platform.

Is this a situation you are facing in your mainline kernel or internal
trees? What you explain would need you to work with hybrid board files
with some devices created through device tree and some others statically
from the board file in the kernel, and that approach was already shot
down as unacceptable.
