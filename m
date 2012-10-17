From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Wed, 17 Oct 2012 22:47:03 +0530
Subject: [PATCH 4/9] uprobes: allow arch access to xol slot
In-Reply-To: <1350242593-17761-4-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-4-git-send-email-rabin@rab.in>
Message-ID: <20121017171703.GH11096@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rabin Vincent <rabin@rab.in> [2012-10-14 21:23:08]:

> Allow arches to customize how the instruction is filled into the xol
> slot.  ARM will use this to insert an undefined instruction after the
> real instruction in order to simulate a single step of the instruction
> without hardware support.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---

The rest of the patches 4,5,6,7 look good. 

-- 
Thanks and Regards
Srikar
