From: mbrugger@suse.com (Matthias Brugger)
Date: Thu,  4 Aug 2016 11:15:13 +0200
Subject: arm64: Implement IPI based TLB invalidation
Message-ID: <1470302117-32296-1-git-send-email-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a workaround for arm64 if the hardware didn't
implement the TLB invalidation via broadcast TLBI properly.
