From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Oct 2018 11:31:15 -0500
Subject: [PATCH 10/14] ARM64: dts: hisilicon: Add interrupt names for the
 tsensors
In-Reply-To: <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20181015163115.GA25282@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 11:03:08AM +0200, Daniel Lezcano wrote:
> Add the missing interrupts for the temperature sensors as well as
> their names.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 8 ++++++--

Combine this and the previous binding change to 1 patch.

>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi                       | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)

And more checkpatch whitespace errors in this.
