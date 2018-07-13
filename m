From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 13 Jul 2018 09:38:28 -0700
Subject: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
References: <20180709212522.187257-1-mka@chromium.org>
 <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
Message-ID: <20180713163828.GW129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 09:00:19AM -0700, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-07-09 14:25:21)
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index 92bed1e7d4bb..7eea94701b23 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -11,6 +11,13 @@
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >  
> > +               pm8998_temp: temp-alarm at 2400 {
> 
> Are we sorting this file based on node name or unit address? Otherwise
> patch looks good.

The idea was to sort by address, following the 'convention' of
sdm845.dtsi (https://patchwork.kernel.org/patch/10381745/).
