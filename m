From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 9 May 2018 16:15:18 -0500
Subject: [PATCH 2/3] arm64: dts: juno: replace '_' with '-' in node names
In-Reply-To: <1525884291-18851-2-git-send-email-sudeep.holla@arm.com>
References: <1525884291-18851-1-git-send-email-sudeep.holla@arm.com>
 <1525884291-18851-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAL_JsqKXXEyzFo9LSspjfN4ge6-skUvN_O3tkh+3oHkqEaMv0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2018 at 11:44 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> The latest DTC throws warnings for character '_' in the node names.
>
> Warning (node_name_chars_strict): /thermal-zones/big_cluster: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /thermal-zones/little_cluster: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /smb at 8000000/motherboard/gpio_keys: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /pmu_a57: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /pmu_a53: Character '_' not recommended in node name
>
> The general recommendation is to use character '-' for all the node names.
> This patch fixes the warnings following the recommendation.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi        | 4 ++--
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 2 +-
>  arch/arm64/boot/dts/arm/juno-r1.dts           | 4 ++--
>  arch/arm64/boot/dts/arm/juno-r2.dts           | 4 ++--
>  arch/arm64/boot/dts/arm/juno.dts              | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
