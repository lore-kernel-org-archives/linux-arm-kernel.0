From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 15 Jan 2011 17:48:40 +0100
Subject: IXP4xx current status
Message-ID: <m3lj2mi047.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just compiled and booted current Linus' git tree on my Goramo
MultiLink (IXP425-based) and it seems to work.

I have two IXP4xx patches to be sent to Linus at this point, including:
- Rename FREQ macro to avoid collisions by Ben Hutchings
- Fix qmgr_release_queue() flushing unexpected queue entries (mine).

If I'm supposed to add anything to this list, please let me know.
-- 
Krzysztof Halasa
