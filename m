From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 Apr 2015 19:39:07 -0600
Subject: [PATCH 2/3 v6] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1430254460-26754-1-git-send-email-eric@anholt.net>
References: <1430173644-19099-3-git-send-email-eric@anholt.net>
 <1430254460-26754-1-git-send-email-eric@anholt.net>
Message-ID: <5540363B.5050800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2015 02:54 PM, Eric Anholt wrote:
> From: Lubomir Rintel <lkundrak@v3.sk>
> 
> This mailbox driver provides a single mailbox channel to write 32-bit
> values to the VPU and get a 32-bit response.  The Raspberry Pi
> firmware uses this mailbox channel to implement firmware calls, while
> Roku 2 (despite being derived from the same firmware tree) doesn't.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
