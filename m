From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Jan 2013 14:06:04 +0530
Subject: [PATCH v5 8/9] ARM: davinci: da850 board: Added .reserve function
 and rproc platform registration
In-Reply-To: <1357863807-380-9-git-send-email-rtivy@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-9-git-send-email-rtivy@ti.com>
Message-ID: <50FCFDF4.9010903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2013 5:53 AM, Robert Tivy wrote:
> Added .reserve function for reserving CMA memory block to MACHINE_START.
> 
> Added call to remoteproc platform device registration function during init.
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>

Looks good to me. I will apply after the driver is accepted.

Thanks,
Sekhar
