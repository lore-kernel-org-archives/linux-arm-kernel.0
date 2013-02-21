From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 21 Feb 2013 16:55:33 +0400
Subject: [PATCH 6/9] ARM: OMAP4+: Remove out of placed smp_wmb() in
 secondary wakeup code
In-Reply-To: <1361373527-21695-7-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <51261945.4040508@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-02-2013 19:18, Santosh Shilimkar wrote:

> The smp_wmb() here is out of placed

    s/placed/place/

> and redundant. So remove it. It is
> a left over of the pain_release

   Sure it's not 'pen_release'?

> cleanup mostly.

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

WBR, Sergei
