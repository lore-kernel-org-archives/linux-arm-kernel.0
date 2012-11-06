From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2012 07:37:21 -0800
Subject: [PATCH] irqchip: irq-bcm2835: Add terminating entry for
 of_device_id table
In-Reply-To: <1351828970-15081-1-git-send-email-swarren@wwwdotorg.org>
References: <1351828970-15081-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121106153721.GD30580@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 10:02:50PM -0600, Stephen Warren wrote:
> From: Axel Lin <axel.lin@ingics.com>
> 
> The of_device_id table is supposed to be zero-terminated.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> This is a fix for v3.7.

Thanks, applied.


-Olof
