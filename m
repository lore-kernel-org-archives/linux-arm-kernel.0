From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 9 Apr 2012 10:51:37 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build
In-Reply-To: <87fwchhge4.fsf@ti.com>
References: <1333660837-23249-1-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1204051533110.10302@utopia.booyaka.com>
 <87fwchhge4.fsf@ti.com>
Message-ID: <alpine.DEB.2.00.1204091046410.6640@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Apr 2012, Kevin Hilman wrote:

> No objections.

Thanks, I took a closer look at this issue over the weekend, and realized 
that I had misunderstood it.  So, will take this patch as-is, as part of 
the io_chain_devel_3.5 series; thanks for the great changelog.

Looking forward to dropping these old OMAP2/3 PRM stubs for OMAP4 soon, 
they've been around for too long :-(

- Paul
