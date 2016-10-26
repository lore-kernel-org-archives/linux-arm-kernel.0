From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 17:03:31 +0530
Subject: [PATCH 1/5] ARM: davinci: Compile MMC in kernel
In-Reply-To: <1477075018-20176-2-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-2-git-send-email-david@lechnology.com>
Message-ID: <f07c399c-f047-9fd5-05b3-0a8ff5a128e3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
> This changes the davinci default configuration to compile the davinci
> MMC driver into the kernel. This allows booting from an SD card without
> requiring an initrd containing the kernel module.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

"build" is more relevant here than "compile" so I changed that. And also
used davinci_all_defconfig as detailed in last e-mail.

Applied to v4.10/defconfig

Thanks,
Sekhar
