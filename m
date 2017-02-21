From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Feb 2017 11:32:43 +0100
Subject: [PATCHv3 net-next 00/12] net: mvpp2: misc improvements and
 preparation patches
In-Reply-To: <20170220.111226.239035932737797178.davem@davemloft.net>
References: <20170220100742.0b1fce4a@free-electrons.com>
 <20170220.095357.2175678121216081406.davem@davemloft.net>
 <20170220164741.11b40d07@free-electrons.com>
 <20170220.111226.239035932737797178.davem@davemloft.net>
Message-ID: <20170221113243.20d2e569@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 20 Feb 2017 11:12:26 -0500 (EST), David Miller wrote:

> For your particular case I'll accept a resubmit.

Resubmit done, patches are now in patchwork. Changes since v3 (also in
the cover letter of v4) :

 - Addition of a patch "net: mvpp2: fix DMA address calculation in
   mvpp2_txq_inc_put()", which fixes a bug in the driver in the
   calculation of DMA addresses. This bug was found using
   DMA_API_DEBUG.

 - Modify the "net: mvpp2: switch to build_skb() in the RX path" patch
   to recalculate the fragment size when the MTU is changed in
   mvpp2_bm_update_mtu().

 - Added Acked-by from Russell King on all patches, except:

    * "net: mvpp2: fix DMA address calculation in
      mvpp2_txq_inc_put()", because it's a new patch

    * "net: mvpp2: switch to build_skb() in the RX path" because I
      modified it since the v3.

 - Rebased on top of 4.10.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
