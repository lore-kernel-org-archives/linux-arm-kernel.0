From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 4 Feb 2016 20:25:25 +0100
Subject: [PATCH v3 22/23] arm64: VHE: Add support for running Linux in
 EL2 mode
In-Reply-To: <1454522416-6874-23-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-23-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160204192525.GI13974@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:00:15PM +0000, Marc Zyngier wrote:
> With ARMv8.1 VHE, the architecture is able to (almost) transparently
> run the kernel at EL2, despite being written for EL1.
> 
> This patch takes care of the "almost" part, mostly preventing the kernel
> from dropping from EL2 to EL1, and setting up the HYP configuration.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
