From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 May 2014 10:09:47 +0100
Subject: [PATCH v10 2/3] Documentation: devicetree: Add new binding for
 PSCIv0.2
In-Reply-To: <1400127090-1320-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1400127090-1320-1-git-send-email-ashwin.chaugule@linaro.org>
 <1400127090-1320-3-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <20140515090947.GC11117@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 05:11:29AM +0100, Ashwin Chaugule wrote:
> The PSCI v0.2+ spec defines standard values for PSCI function IDs.
> Add a new binding entry so that pre v0.2 implementations can
> use DT entries for function IDs and v0.2+ implementations use
> standard entries as defined by the PSCIv0.2 specification.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
