From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Aug 2014 14:50:15 +0530
Subject: [PATCH] ARM: edma: Fix configuration parsing for SoCs with
 multiple eDMA3 CC
In-Reply-To: <1407155216-20267-1-git-send-email-peter.ujfalusi@ti.com>
References: <1407155216-20267-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <53FC514F.6060206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 August 2014 05:56 PM, Peter Ujfalusi wrote:
> The edma_setup_from_hw() should know about the CC number when parsing the
> CCCFG register - when it reads the register to be precise. The base
> addresses for CCs stored in an array and we need to provide the correct id
> to edma_read() in order to read the correct register.
> 
> Cc: <stable@vger.kernel.org> # 3.16
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied and will queue for v3.17-rc

Thanks,
Sekhar
