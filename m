From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 19 Apr 2012 01:53:45 +0530
Subject: [PATCH] arm: davinci: pdctl next bit position incorrect
In-Reply-To: <1334745664-19275-1-git-send-email-m-karicheri2@ti.com>
References: <1334745664-19275-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <4F8F22D1.8080309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

On 4/18/2012 4:11 PM, m-karicheri2 at ti.com wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> The PDCTL NEXT bit is incorrectly set to bit 1 instead of bit 0. This
> patch fixes this issue
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Applying this for v3.5. Note that the "arm:" prefix in subject has to be
capitalized. I fixed it while comitting. Please take care next time on.

Thanks,
Sekhar
