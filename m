From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 11 Dec 2009 09:44:18 +0000
Subject: perf events for ARMv6
Message-ID: <1260524662-30683-1-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides support for software perf events on all
ARM platforms and hardware support for v6 CPUs. In addition to adding
support for the hardware counters, these patches provide a way of
arbitrating access to the PMU and patches the oprofile code to use this.

Jamie
