From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 11:07:55 +0100
Subject: [PATCH 0/2] ARM: honor Thumb bit when calling procinfo setup
 functions
In-Reply-To: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150421100755.GT12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 11:06:43AM +0200, Ard Biesheuvel wrote:
> This addresses the observed issue where we are inadvertently relying
> on the procinfo setup function to use the same instruction set as the
> call site instead of using the correct annotation (patch #1) and call
> sequence (patch #2)
> 
> Ard Biesheuvel (2):
>   ARM: include Thumb2 bit in PROCINFO setup function offset
>   ARM: prefer "bx reg" over "mov pc, reg" for all registers

Patch 1 is missing.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
