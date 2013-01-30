From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 30 Jan 2013 11:30:56 +0530
Subject: [RFC PATCH v2 0/2] ARM: update cpuinfo to print SoC model name
In-Reply-To: <1359506337-21619-1-git-send-email-ruslan.bilovol@ti.com>
References: <1359506337-21619-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <5108B718.3050507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013 06:08 AM, Ruslan Bilovol wrote:
> The following patches update cpuinfo to print SoC
> model name for ARM.
> The first patch exactly makes needed changes for ARM
> architecture and adds a common approach to show SoC name.
> Second patch uses this approach for OMAP4 SoCs (as live
> example).
>
> Looks like there were few attempts to do similar
> changes to cpuinfo without any luck (had stuck
> on review) so this functionality is still not
> in the kernel yet.
> In this patch series the update to cpuinfo is very
> short (10 lines) and easy.
>
> Comments are welcome as usual
>
As most of the people already commented, your purpose
behind the series isn't clear so please give examples
where and why you need  device type information from
user-space.

Regards,
Santosh
