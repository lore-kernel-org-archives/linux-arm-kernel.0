From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 25 Sep 2015 11:54:35 -0700
Subject: [PATCH 09/14] ARM: dts: ifc6410: Add missing pinctrl to gsbi7 uart
In-Reply-To: <1442579507-20314-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1442579507-20314-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAMAWPa_7U-PBwsngU+qc5SAt4HcCvPwUGvGY9nPUu+pZtPA7Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

On Fri, Sep 18, 2015 at 5:31 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch adds missing 2pin uart pinctrl property to gsbi7 uart on
> IFC6410.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

kernelci.org found some new boot failures in -next on 8064[1].  I
bisected it down to this patch, which landed in linux next in the form
of commit d3a578ed4310 ARM: dts: ifc6410: Add missing pinctrl to gsbi7
uart.

Kevin

[1] http://kernelci.org/boot/qcom-apq8064-ifc6410/job/next/kernel/next-20150925/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=5605083c59b51466d26c3250
