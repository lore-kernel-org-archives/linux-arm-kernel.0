From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 12 Mar 2015 11:57:42 +0100
Subject: [PATCH 3.18 stable] ARM: mvebu: do not register custom DMA
 operations when coherency is disabled
In-Reply-To: <20150312105708.GM2177@tarshish>
References: <1426157350-23120-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150312105708.GM2177@tarshish>
Message-ID: <20150312115742.4b6fcaf6@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Baruch Siach,

On Thu, 12 Mar 2015 12:57:08 +0200, Baruch Siach wrote:

> > It does make a lot of sense to backport this commit entirely, since it
> 
> "It does not" maybe?

Obviously, thanks for spotting. I'll send a v2 that fixes that.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
