From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Mar 2011 11:59:14 +0900
Subject: [PATCH v6] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
Message-ID: <1301453955-15759-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

could I get an Ack or otherwise from you on this change?
All the pre-requisites are in 2.6.39-rc1.

Note that if you are inclined to build a 2.6.39-rc1 kernel for mackerel you
will also need "sh: intc: fix build error in interrupts.h"
(https://patchwork.kernel.org/patch/672972/) or similar.  That change is
unrelated to my work.
