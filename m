From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 17:24:42 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120730085040.GG3347@b20223-02.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120727063334.GC3347@b20223-02.ap.freescale.net>
 <20120730081750.GC31509@S2101-09.ap.freescale.net>
 <20120730085040.GG3347@b20223-02.ap.freescale.net>
Message-ID: <20120730092440.GG31509@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:50:41PM +0800, Richard Zhao wrote:
> I think the real problem here is OPP only provide exact voltage but
> regulator api needs a range.
> 
Maybe OPP will get improved on that when the real use cases occur.

> IIRC, cpufreq driver init is called every time a new cpu get online.
> So things that only needs to be done once can be put in module init.
> 
Ah, right.  Something should be moved to module init then.

-- 
Regards,
Shawn
