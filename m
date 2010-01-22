From: t.fujak@samsung.com (Tomasz Fujak)
Date: Fri, 22 Jan 2010 13:08:58 +0100
Subject: [PATCH/RFC v1 0/1] Platform-specific event support in the perf
Message-ID: <1264162139-26788-1-git-send-email-t.fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The folowing patch upgrades the perf with extended performance event description, as proposed in a separate RFC.
You can find it here: http://article.gmane.org/gmane.linux.ports.arm.kernel/72822

It has been tested on a ARMv7 Cortex-A8 incarnation.
Event names can be specified to -e switch, and are reported in the list command.

The perf-predefined commands take precedence (if a collision occurs) over the platform-specific ones.
A workaround for that is though - specify the raw event, as seen provided by the system.
Currently it resides in the sysfs, but I've already been pointed to a sysfs note disclaiming mixed types, multiple lines and fancy formatting. Might swith over to debugfs.


Thanks,
-- 
Tomasz Fujak
