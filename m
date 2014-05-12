From: w@1wt.eu (Willy Tarreau)
Date: Mon, 12 May 2014 17:30:21 +0200
Subject: [PATCH 2/2] ARM: mvebu: mvebu-soc-id: keep clock enabled if PCIe
 unit is enabled
In-Reply-To: <1399903900-29977-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399903900-29977-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140512153021.GC19173@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, May 12, 2014 at 04:11:40PM +0200, Thomas Petazzoni wrote:
(...)
> This issue was discussed with Kevin Hilman, and the suggested solution
> was to make the mvebu-soc-id code keep the clock enabled in case it
> will be needed for PCIe. This is therefore the solution implemented in
> this patch.

Great, I'll give it a try ASAP both on the mirabox and the XP-GP
board.

Willy
