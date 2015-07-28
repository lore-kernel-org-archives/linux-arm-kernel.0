From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jul 2015 09:55:25 +0100
Subject: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
In-Reply-To: <20150728083513.GA26276@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <20150728083513.GA26276@linux>
Message-ID: <20150728085525.GQ14943@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jul 2015, Viresh Kumar wrote:

> On 27-07-15, 16:20, Lee Jones wrote:
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > 
> > Changelog:
> >  - Using OPP-v2
> >  - Moved (and linked) a bunch of documentation to ../power/
> > 
> >  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 40 ++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> 
> For both patches:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

W00t!  I'll start fixing up the driver.

> But I would like Rob to have a look as well :)

No problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
