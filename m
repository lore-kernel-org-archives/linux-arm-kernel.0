From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Oct 2013 17:03:14 +0530
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <20131028113104.GE27015@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
 <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
 <20131023135116.GC31126@lunn.ch>
 <CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
 <20131023143657.GA31536@lunn.ch>
 <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
 <20131028113104.GE27015@lunn.ch>
Message-ID: <CAKohponoxbV9P+0pWfEEi3sND7GbgHECsT=FRMCfeLcvOP9iDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2013 17:01, Andrew Lunn <andrew@lunn.ch> wrote:
> I have tested this now. The dummy handler is required. Without it, it
> seems like the WFI exits at the next timer tick, not immediately once
> the cpufreq change has finished. I get poor numbers out of
> cpufreq-bench without the handler.

Ahh.. that helps.. You can now put exactly this stuff in the comment over
the handler..
