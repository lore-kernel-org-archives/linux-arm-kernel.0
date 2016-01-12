From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 12 Jan 2016 16:22:01 -0600
Subject: [PATCH 1/5] arm64: dts: apq8016-sbc: add regulators support
In-Reply-To: <56950E0A.2000005@linaro.org>
References: <1452606358-24569-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1452606392-24614-1-git-send-email-srinivas.kandagatla@linaro.org>
 <7998607.BblzgPxGPW@wuerfel> <56950E0A.2000005@linaro.org>
Message-ID: <20160112222201.GA4125@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 02:30:34PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 12/01/16 13:59, Arnd Bergmann wrote:
> >On Tuesday 12 January 2016 13:46:32 Srinivas Kandagatla wrote:
> >>         };
> >>
> >>+       smd {
> >>+               rpm {
> >>+                       rpm-requests {
> >>+                               pm8916-regulators {
> >>+
> >>+                                       vdd_l1_l2_l3-supply = <&pm8916_s3>;
> >>+                                       vdd_l5-supply = <&pm8916_s3>;
> >>+                                       vdd_l4_l5_l6-supply = <&pm8916_s4>;
> >>+                                       vdd_l7-supply = <&pm8916_s4>;
> >>+
> >>
> >
> >If you're nested this deeply, you should consider using labels, e.g.
> >
> Labels are good and works for me.
> 
> Stephen/Andy are you ok to use labels for such deeply nested nodes in board
> dts?

I tend to agree with Arnd.  I am ok with using labels.

<snip>
