From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 2 Aug 2011 00:42:50 +0200
Subject: [PATCH 0/3] mmp clockevent handling race fix
Message-ID: <20110801224250.GF912@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a minimal fix for the mmp clockevent handling race reported
earlier:

	http://marc.info/?l=linux-arm-kernel&m=130745534131879&w=2
	http://dev.laptop.org/ticket/10945

This version needs some more testing, but looks OK so far.
