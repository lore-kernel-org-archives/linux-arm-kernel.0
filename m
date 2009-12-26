From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 26 Dec 2009 21:25:46 +0100
Subject: [PATCH 0/4] pxa/zeus: Fixes for 2.6.33
Message-ID: <1261859150-17335-1-git-send-email-maz@misterjones.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie of patches fixes a few problems with the Arcom Zeus.

[PATCH 1/4] pxa/zeus: Allow usage of 8250-compatible UART in uncompress
[PATCH 2/4] pxa/zeus: Make internal zeus_get_pcb_info static
[PATCH 3/4] pxa/zeus: Relax memory timings on Zeus ethernet ports
[PATCH 4/4] pxa/zeus: provide power-source information when APM is enabled

I'd appreciate if they could make it for 2.6.33.

Thanks,

        M.
