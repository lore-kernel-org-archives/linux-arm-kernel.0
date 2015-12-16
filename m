From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 16 Dec 2015 17:00:55 +0000
Subject: [PATCH 2/2] arm-cci: CoreLink CCI-550 PMU driver
In-Reply-To: <1447785040-18599-3-git-send-email-suzuki.poulose@arm.com>
 (Suzuki K. Poulose's message of "Tue, 17 Nov 2015 18:30:40 +0000")
References: <1447785040-18599-1-git-send-email-suzuki.poulose@arm.com>
 <1447785040-18599-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <87lh8utjjs.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Suzuki K. Poulose" <suzuki.poulose@arm.com> writes:

> Add ARM CoreLink CCI-550  cache coherent interconnect PMU
> driver support. The CCI-550 PMU shares all the attributes of CCI-500
> PMU, except for an additional master interface (MI-6 - 0xe).
> CCI-550 requires the same work around as for CCI-500 to
> write to the PMU counter.
>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cci.txt |    2 +
>  drivers/bus/Kconfig                           |    8 +--
>  drivers/bus/arm-cci.c                         |   85 ++++++++++++++++++++++++-
>  3 files changed, 90 insertions(+), 5 deletions(-)

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks,
Punit
