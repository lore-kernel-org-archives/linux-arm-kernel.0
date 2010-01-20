From: t.fujak@samsung.com (Tomasz Fujak)
Date: Wed, 20 Jan 2010 10:11:44 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event description in
	sysfs
Message-ID: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While I managed to build and run the early version (back from December), I was unable to find the newest sources (infra + ARMv6, ARMv7 support).
Where do I find them?

The following patches provide a sysfs entry with hardware event human readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" % (event_value, minval, maxval, name, description) and means to populate the file.
The version posted contains ARMv6, ARMv7 (Cortex-A[89]) support in this matter.

The intended use is twofold: for users to read the list directly and for tools (like perf).

This series includes:
[PATCH v1 1/2] perfevent: Add performance event structure definition and 'extevents' sysfs entry
[PATCH v1 2/2] [ARM] perfevent: Event description list for ARMv6, Cortex-A8 and Cortex-A9 exported

Thanks,
-- 
Tomasz Fujak
