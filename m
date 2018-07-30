From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Jul 2018 17:14:40 -0600
Subject: [PATCH v3 9/9] dts: juno: Update coresight bindings
In-Reply-To: <1532686537-12380-10-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <1532686537-12380-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180730231440.GA7782@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 11:15:37AM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for Juno platforms.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>   - Update to new format.
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi    | 161 +++++++++++++++---------------
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  52 ++++------
>  arch/arm64/boot/dts/arm/juno.dts          |  13 +--
>  3 files changed, 105 insertions(+), 121 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
