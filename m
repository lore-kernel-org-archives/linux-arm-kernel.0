From: yxit@yxit.co.uk (Tixy)
Date: Mon, 22 Aug 2011 14:06:11 +0100
Subject: Submitting patchset: ARM: Remove define CONSISTENT_DMA_SIZE
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1314018371.3604.27.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was wondering how I should submit the patches for removing
CONSISTENT_DMA_SIZE. Following on from the thread in linux-arm-kernel
titled "Patch Merging Path - RMK or Arnd?" [1], I'm guessing...

- Patch one, "ARM: Add init_consistent_dma_size()" to go into RMK's tree
- All the patches to go into the arm-soc tree

Or do we have a plan to bundle up the cleanup patches for the single
zImage work?

-- 
Tixy

[1] http://www.spinics.net/lists/arm-kernel/msg137059.html
