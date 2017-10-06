From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 6 Oct 2017 16:19:43 -0700
Subject: [PATCH 0/2] memory: brcmstb: dpfe: skip downloading firmware
In-Reply-To: <20171002231347.8671-1-code@mmayer.net>
References: <20171002231347.8671-1-code@mmayer.net>
Message-ID: <c53fe52f-024a-1721-b4b1-16beb1405f0d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2017 04:13 PM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> This series lets the DPFE driver skip the DPFE firmware download if the
> DCPU is already running. If it's running by the time Linux comes up, it
> means the boot loader already downloaded the DPFE firmware.

Series applied to drivers/next thanks Markus.
-- 
-- 
Florian
