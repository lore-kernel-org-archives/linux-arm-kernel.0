From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 17 Jun 2014 16:31:18 +0800
Subject: ARM diagnostic register across suspend/resume
Message-ID: <20140617083117.GD8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Catalin,

The CP15 diagnostic register holds some bits for ARM errata workaround.
Since core gets power gated across suspend/resume cycle, these bits will
get lost along the way.  Is it okay for errata workaround to continue
working after suspend, or do we have to save/restore diagnostic register
to keep workaround effective?

Shawn
