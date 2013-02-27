From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Feb 2013 17:15:59 +0530
Subject: [PATCH v4 1/5] ARM: davinci: mmc: derive version information
 from device name
In-Reply-To: <1360909322-1858-2-git-send-email-prakash.pm@ti.com>
References: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
 <1360909322-1858-2-git-send-email-prakash.pm@ti.com>
Message-ID: <512DF1F7.6010508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/15/2013 11:51 AM, Manjunathappa, Prakash wrote:
> Remove specifying mmc controller IP version information via platform
> data, instead specify device name so that driver derives it from
> platform_device_id table. Also change the clock node name to match
> the changed dev_id.
> Tested on da850-evm to make sure driver loads without clk_get failures.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

The patch looks good to me, but after this patch MMC/SD will be broken.
I suggest merging this into 2/5. It makes little sense without those
changes anyway.

Thanks,
Sekhar
