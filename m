From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Mar 2012 21:27:27 -0700 (MST)
Subject: [PATCH 00/12] ARM: OMAP2+: hwmod: remove link arrays
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Message-ID: <alpine.DEB.2.00.1203082123540.26656@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series has been rebased on top of a merge of the hwmod_misc_devel_3.4 
branch and the hwmod_data_cleanup_3.4 branch, both previously posted.  
Fortunately the auto-merger came up with something reasonable.  Patches 5 
and 7 have been trivially updated to take account of the SmartReflex 
changes.  The updated series has been posted at:

http://www.pwsan.com/omap/patches-hwmod_remove_link_arrays_cleanup_3.4_2

since the two patches that changed were the ones that were too big to make 
it onto the lists.

The updated branch is in the same place as before: 
git://git.pwsan.com/linux-2.6 in the 
'hwmod_remove_link_arrays_cleanup_3.4' branch.


- Paul
