From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 26 Jan 2012 15:21:41 +0400
Subject: [PATCH 08/21] OMAP3+: Smartreflex: Add a shutdown hook
In-Reply-To: <1327504583-13408-9-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-9-git-send-email-j-pihet@ti.com>
Message-ID: <4F213745.3040807@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> Since OMAP's VP and PRM modules do not get reset by warm reset,
> we should ensure that proper shutdown procedure is followed prior
> to allowing the kernel to reboot back up.
>
> Without this patch, Smartreflex module might be left active or
> system might be caught in an indeterminate sequence when reboot
> is triggered, leaving the next reboot behavior to be unpredictable.

> Change-Id: I7f8c66cc45f8785394cce1fdde3cfda15ecc1fbc

    This line has no place in the upstream patch, please remove it.

> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++++++++++++++
>   1 files changed, 24 insertions(+), 0 deletions(-)

WBR, Sergei
