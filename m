From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 24 Oct 2013 07:47:35 +0530
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <20131023145915.GA31745@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
 <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
 <20131023135116.GC31126@lunn.ch>
 <CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
 <20131023143657.GA31536@lunn.ch>
 <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
 <20131023145915.GA31745@lunn.ch>
Message-ID: <CAKohpokz2SJnB1_uejtE1opmJ1ReSGO8urjMV7v3ihNX6N-qZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 20:29, Andrew Lunn <andrew@lunn.ch> wrote:
> So you want to know if WFI exits without an interrupt being delivered?

Yeah..

> The Marvell documentation says the interrupt should be enabled, but we
> can try it with it disabled.

Yes, that will work.. So we will not explicitly disable interrupt but let kernel
do it for us (i.e. by not registering an interrupt handler)..
