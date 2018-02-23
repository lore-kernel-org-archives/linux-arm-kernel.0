From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 23 Feb 2018 17:21:28 +0530
Subject: [PATCH v2 1/2] ARM: dts: da850-lego-ev3: Add node for reboot modes
In-Reply-To: <1515724191-30499-2-git-send-email-david@lechnology.com>
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
 <1515724191-30499-2-git-send-email-david@lechnology.com>
Message-ID: <08386992-0df8-2db7-76d6-98bda137bb49@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 January 2018 07:59 AM, David Lechner wrote:
> This adds a new node for reboot modes on LEGO MINDSTORMS EV3. The EV3's
> bootloader looks for a magic number in the ARM local RAM and if found,
> it will boot into a special firmware update mode where the flash memory
> can be written via USB.
> 
> This has been testing working using the command:
> 
>     # systemctl reboot loader
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Added to v4.17/dt

Thanks,
Sekhar
