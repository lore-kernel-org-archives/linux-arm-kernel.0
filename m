From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 Apr 2012 23:29:18 +0530
Subject: [PATCH v2] arm: davinci: use for_each_set_bit_from
In-Reply-To: <1334144213-25870-1-git-send-email-akinobu.mita@gmail.com>
References: <1334144213-25870-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <4F8DAF76.8070801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akinobu,

On 4/11/2012 5:06 PM, Akinobu Mita wrote:
> Use for_each_set_bit_from to iterate over all the set bit in a memory
> region.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Christian Riesch <christian.riesch@omicron.at>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> v2: remove uncorrect semicolon at the end of the line found by Christian Riesch

Yes, good catch by Christian. Queuing this one for v3.5

Thanks,
Sekhar
