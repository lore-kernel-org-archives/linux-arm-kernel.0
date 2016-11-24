From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 24 Nov 2016 11:31:07 +0530
Subject: [PATCH v4 0/2] da8xx: fix section mismatch in new drivers
In-Reply-To: <1479908400-10136-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479908400-10136-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <0b32361c-d064-0476-546c-c0ed0088c962@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 November 2016 07:09 PM, Bartosz Golaszewski wrote:
> Sekhar noticed there's a section mismatch in the da8xx-mstpri and
> da8xx-ddrctl drivers. This is caused by calling
> of_flat_dt_get_machine_name() which has an __init annotation.
> 
> This series makes the drivers drop the call and not print the
> machine name in the error message.

Applied both. Thanks!

Regards,
Sekhar
