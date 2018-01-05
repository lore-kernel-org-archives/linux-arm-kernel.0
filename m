From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Jan 2018 19:26:46 +0530
Subject: [PATCH 07/12] ARM: davinci: drop unneeded newline
In-Reply-To: <1514386305-7402-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514386305-7402-8-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <7bad6990-b54d-2373-86b0-7926f636f51d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 December 2017 08:21 PM, Julia Lawall wrote:
> gpio_request uses its second argument as a label, so it doesn't seem
> appropriate for it to have a newline.  Done using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to my v4.16/soc branch

Thanks,
Sekhar
