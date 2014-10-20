From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 14:36:09 -0700
Subject: [PATCH v5 0/6] add basic rk3288 smp support
In-Reply-To: <1413393785-26783-1-git-send-email-kever.yang@rock-chips.com>
 (Kever Yang's message of "Wed, 15 Oct 2014 10:22:59 -0700")
References: <1413393785-26783-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <7hh9yye852.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever Yang <kever.yang@rock-chips.com> writes:

> rk3288 is qual-core CPU Soc, we enable the smp in this patch.
>
> In version 3 we use regmap and pmu syscon for cpu power on/off.
> This should be work after Pankaj Dubey's patch applied:
> "syscon: Decouple syscon interface from platform devices"
> (https://lkml.org/lkml/2014/9/30/156)

Tested on top of linux-next (next-20141020) along with above syscon
dependency, and verifed that 4 CPUs boot up on my rk3288-evb-rk808.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
