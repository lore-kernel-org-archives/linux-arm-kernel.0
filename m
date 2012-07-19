From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Jul 2012 08:44:42 -0600 (MDT)
Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
 suspend
In-Reply-To: <1342704392-23657-8-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-8-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jul 2012, Tero Kristo wrote:

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This one needs at least some short description for the changelog.  Maybe 
just a brief explanation that OSWR saves more energy that CSWR, but has 
higher resume latency, and since resume from system suspend is considered 
to be a high-latency operation, OSWR is appropriate here.


- Paul
