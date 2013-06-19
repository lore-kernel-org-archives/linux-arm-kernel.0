From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 17:29:57 +0100
Subject: ARM big-endian - atags and loader updates
Message-ID: <1371659404-20167-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a series of patches to update the system to support little-endian
boot loaders with big-endian kernels. Mostly fixes for ATAGS parsing
and loader magic values.
