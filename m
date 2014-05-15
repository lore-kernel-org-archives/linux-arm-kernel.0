From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 May 2014 10:09:26 +0100
Subject: [PATCH v10 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <1400127090-1320-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1400127090-1320-1-git-send-email-ashwin.chaugule@linaro.org>
 <1400127090-1320-2-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <20140515090925.GB11117@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 05:11:28AM +0100, Ashwin Chaugule wrote:
> The PSCIv0.2 spec defines standard values of function IDs
> and introduces a few new functions. Detect version of PSCI
> and appropriately select the right PSCI functions.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
