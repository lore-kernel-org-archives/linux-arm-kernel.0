From: sdharia@codeaurora.org (Sagar Dharia)
Date: Mon, 4 Jun 2012 03:25:32 -0700 (PDT)
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <1338741260.1881.14.camel@joe2Laptop>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
 <1338741260.1881.14.camel@joe2Laptop>
Message-ID: <0b49042fd7b1b02788b29ccbe0b9b31a.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Reallocs should _always_ use a new temporary.
> Otherwise, there will be a memory leak of the
> original pointer memory on failure.
>
Thank you Joe for your comments. I will change the allocs, take care of
the styling based on your comments when I split the patch and resubmit.

Regards
Sagar

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
