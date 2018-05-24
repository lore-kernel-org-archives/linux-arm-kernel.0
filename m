From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 24 May 2018 14:09:28 -0500
Subject: [PATCH 0/4] arm64: align KPTI interface with x86
Message-ID: <20180524190932.32118-1-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 supports KPTI, but is missing some user interface features such as
a debugfs entry compared to the x86 implementation.

Add the nopti argument, update the documentation so that ARM64 as well
as x86 supports nopti and kpti, and add a debugfs entry to check the
status of the kpti on a running machine.

--Mark Langsdorf
