From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 14 Jun 2016 11:35:42 +0100
Subject: [PATCH 2/2] arm64: dts: juno: add thermal zones for scpi sensors
In-Reply-To: <1465830915-16342-3-git-send-email-javi.merino@arm.com> (Javi
 Merino's message of "Mon, 13 Jun 2016 16:15:15 +0100")
References: <1465830915-16342-1-git-send-email-javi.merino@arm.com>
 <1465830915-16342-3-git-send-email-javi.merino@arm.com>
Message-ID: <87h9cw6osh.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javi Merino <javi.merino@arm.com> writes:

> The juno dts have entries for the hwmon scpi, let's create thermal zones
> for the temperature sensors described in the Juno ARM Development
> Platform Implementation Details.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>

I've reviewed the sensor ids against documentation and tested this on
Juno r2. For the cluster and gpu thermal zones to function, I had to
update the firmware.

For the device tree changes -

    Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks

> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 42 ++++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/arm/juno-r1.dts    | 16 +++++++++++++
>  arch/arm64/boot/dts/arm/juno-r2.dts    | 16 +++++++++++++
>  3 files changed, 74 insertions(+)
>

[...]
