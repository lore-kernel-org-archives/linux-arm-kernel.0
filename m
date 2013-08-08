From: xdai@uoregon.edu (Ender Dai)
Date: Thu, 08 Aug 2013 11:29:23 -0700
Subject: exclude_* flags for perf_event_open()
Message-ID: <87iozgniik.fsf@cortana.d.cs.uoregon.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I know that kernel already support those flags for PMUv2 enabled chips
with event filter. However, for PMUv1 chips without event filter
capability, those flags are simply not supported.

Considering that we can manually enable/disable any event counters for
both PMUv1 and PMUv2 chips, technically we can support exlcude_* flags
for PMUv1 chips by enable/disable the event counters in appropriate
time manully.

As fearless kernel hackers didn't do that till now, I am almost sure
that I missed some apparent truth here. So, what's that?

Thanks,
Ender
