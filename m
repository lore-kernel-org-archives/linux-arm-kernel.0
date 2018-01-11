From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 07:47:07 -0600
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
Message-ID: <CAL_JsqJT+987J89+SqZEgC6C=ioGwLHKrRWxPSFKHV7UN5JewA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 11:58 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The interrupt-parent of rtc was missing, add it.
>
> Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
> Cc: stable at vger.kernel.org # v3.8+
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/spear600.dtsi | 1 +
>  1 file changed, 1 insertion(+)

For all three patches:

Reviewed-by: Rob Herring <robh@kernel.org>
