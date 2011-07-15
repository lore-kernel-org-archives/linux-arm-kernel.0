From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri, 15 Jul 2011 11:03:59 -0400
Subject: [PATCH 0/3] SP805 updates for Versatile Express
Message-ID: <1310742242-14647-1-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some updates to get the SP805 watchdog working on the ARM
Versatile Express.  The first two patches fix observed issues; the
third fixes a potential (but not observed) issue with asynchronous
posted writes.

All three patches are independent and should be applicable in any
order, with some fuzz on the third.
