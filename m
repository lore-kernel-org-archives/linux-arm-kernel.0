From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 23 Feb 2018 17:24:12 +0530
Subject: [PATCH v2 2/2] ARM: davinci_all_defconfig: enable
 SYSCON_REBOOT_MODE
In-Reply-To: <1515724191-30499-3-git-send-email-david@lechnology.com>
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
 <1515724191-30499-3-git-send-email-david@lechnology.com>
Message-ID: <ce54ca3f-2bef-8001-19d9-6e493f92fed9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 January 2018 07:59 AM, David Lechner wrote:
> This enables SYSCON_REBOOT_MODE as a module. This is used by LEGO
> MINDSTORMS EV3 to reboot into a special firmware update mode.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.17/defconfig

Thanks,
Sekhar
