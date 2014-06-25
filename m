From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jun 2014 10:54:06 +0100
Subject: [PATCH 1/1] clk-imx35: Add clko clock support
In-Reply-To: <1857714.L0sRRUOXiN@ws-stein>
References: <1402990063-26908-1-git-send-email-alexander.stein@systec-electronic.com>
 <2789534.qY6c0ymzGl@ws-stein> <20140625065302.GB2224@dragon>
 <1857714.L0sRRUOXiN@ws-stein>
Message-ID: <20140625095406.GG32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 10:58:12AM +0200, Alexander Stein wrote:
> Well, the cko (cko1 and cko2) clocks on i.MX6 are also added. Though
> I can't find any user of that. So why addind it despite that?

They are definitely used, I've recently added one user to my DT config,
and there are other users in the DT configs already present in the
kernel tree.  Look for <&clks 201> for iMX6.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
