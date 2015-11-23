From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Nov 2015 15:25:33 +0300
Subject: [PATCH 1/2] ARM: shmobile: alt: Correct scif2 pfc
In-Reply-To: <1448263004-14548-2-git-send-email-horms+renesas@verge.net.au>
References: <1448263004-14548-1-git-send-email-horms+renesas@verge.net.au>
 <1448263004-14548-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <565305BD.5070306@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/23/2015 10:16 AM, Simon Horman wrote:

> 0c9400fab882 ("Merge branch 'heads/dt-for-v4.5' into next") introduced
> pfc pins to the alt device tree but did not reference them. This patch

    Merge introduced? I thought there was a concrete commit doing that...

> fixes scif2 pfc by adding references to the scif2 pins.
>
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[...]

MBR, Sergei
