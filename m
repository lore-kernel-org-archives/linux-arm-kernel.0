From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jun 2015 10:00:25 +0100
Subject: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
In-Reply-To: <20150623083055.GJ16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux> <20150623071647.GD3245@x1>
 <20150623080309.GI16776@linux> <20150623082759.GF3245@x1>
 <20150623083055.GJ16776@linux>
Message-ID: <20150623090025.GJ3245@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jun 2015, Viresh Kumar wrote:

> On 23-06-15, 09:27, Lee Jones wrote:
> > Okay, but the reasoning is the same.  I consider the function to have
> > failed, but the over-all failure culminates in just a warning that
> > voltage scaling has indeed failed, but we can still go on with
> > frequency scaling.
> 
> Ahh, I thought that the other opp-table will also have voltages.

Nope.  See patch 1.

> > Unless his is a big blocker for you, I would like to keep these
> > semantics.
> 
> No, the print is actually fine.

Perfect, thanks.

> > So technically you are correct, but it makes the code slightly more
> > confusing IMHO.  Yes, it's one more line of code, but it's worth it to
> > add clarity.
> 
> Your call :)

Thanks again.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
