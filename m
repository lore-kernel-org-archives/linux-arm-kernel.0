From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Dec 2013 14:55:11 +0000
Subject: [PATCH v4 4/4] mvebu: Dove: Add clocks and DFS interrupt to
 cpu node in DT.
In-Reply-To: <20131204143921.GC29200@e106331-lin.cambridge.arm.com>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-5-git-send-email-andrew@lunn.ch>
 <20131204143921.GC29200@e106331-lin.cambridge.arm.com>
Message-ID: <20131204145511.GE29200@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 02:39:21PM +0000, Mark Rutland wrote:
> Is ddrclk actually fed into the CPU? Given that you seem to have an
> external L2 I don't see why the CPU would need the DDR clock.

I see from the other patches that it's simply a misleading name. Sorry
for the noise.

Mark.
