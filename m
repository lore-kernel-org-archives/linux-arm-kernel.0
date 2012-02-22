From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Feb 2012 15:01:09 -0800
Subject: [PATCH 1/7] OMAP: 4430SDP: Correct fixed regulator device ID
In-Reply-To: <1328868316-24749-2-git-send-email-peter.ujfalusi@ti.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868316-24749-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120222230109.GQ18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120210 01:34]:
> The board has two fixed voltage regulator. Correct the
> device ID for the vbat, which used -1.
> Create defines for the fixed regulator IDs so when adding new
> regulators we know the next available ID to use for them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
