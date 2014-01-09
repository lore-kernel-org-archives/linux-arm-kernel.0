From: broonie@kernel.org (Mark Brown)
Date: Thu,  9 Jan 2014 17:05:02 +0000
Subject: [PATCH v10 0/4] arm64 topology
Message-ID: <1389287106-29979-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another round of minor tweaks

 - Remove some problematic and controversial prints
 - Pass cluster_id around as a pointer
 - Move slab.h further back in the series

   arm64: topology: Implement basic CPU topology support
   arm64: topology: Add support for topology DT bindings
   arm64: topology: Tell the scheduler about the relative
   arm64: topology: Provide relative power numbers for cores
