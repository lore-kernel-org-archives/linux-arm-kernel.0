From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Mar 2013 15:07:25 +0530
Subject: [PATCH] ARM: davinci: defconfig: enable CGROUPS
In-Reply-To: <1362395541-3564-1-git-send-email-nsekhar@ti.com>
References: <1362395541-3564-1-git-send-email-nsekhar@ti.com>
Message-ID: <514831D5.2030209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/2013 4:42 PM, Sekhar Nori wrote:
> Newer filesystems like Fedora-18 don't support kernels where
> cgroups is not enabled.
> 
> Enable it in defconfig so users don't have to enable
> it themselves.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Queuing this for v3.10

Thanks,
Sekhar
