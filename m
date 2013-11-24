From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 24 Nov 2013 19:14:15 +0400
Subject: [PATCH] mm: nobootmem: avoid type warning about alignment value
In-Reply-To: <1385249326-9089-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385249326-9089-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <529217C7.6030304@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-11-2013 3:28, Santosh Shilimkar wrote:

> Building ARM with NO_BOOTMEM generates below warning. Using min_t

    Where is that below? :-)

> to find the correct alignment avoids the warning.

> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

WBR, Sergei
