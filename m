From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 28 Jul 2015 13:20:27 +0530
Subject: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
In-Reply-To: <20150728074104.GL21114@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <20150728022308.GA1229@linux> <20150728074104.GL21114@x1>
Message-ID: <20150728075027.GB13710@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing Rob as well..

On 28-07-15, 08:41, Lee Jones wrote:
> I have two issues with that.  Firstly, although the driver uses the
> OPP API (it also uses the Regulator and Clock API too), it is
> fundamentally a CPUFreq driver, so I think it should have a CPUFreq
> DT entry.  Secondly, if someone doesn't know the history of the
> ST CPUFreq set, they will look here for an accompanying document.  I
> personally wouldn't think to look in power/*opp* for a CPUFreq
> binding.
> 
> Perhaps, as all of the CPUFreq drivers use the OPP API, everything
> should be moved to drivers/base/power or drivers/power?

Okay, looks fine :)

-- 
viresh
