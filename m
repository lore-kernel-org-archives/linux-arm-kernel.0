From: ccross@android.com (Colin Cross)
Date: Mon, 21 Feb 2011 18:39:45 -0800
Subject: [PATCH 0/7] Second batch of Tegra clock updates for 2.6.39
Message-ID: <1298342392-21236-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains two small patches out of the previous
series that needed fixes, as well as some new ones to disable
unused clocks during boot and related bug fixes.

Patch 4 converts the Harmony and Trimslice boards to use the new
init_early machine handler.  Any boards that go in after this
patch will need to be updated to match, and this patch will need
to be updated if any boards go in before this patch.

Tested-bys on Harmony and Trimslice would be appreciated.
