From: broonie@kernel.org (Mark Brown)
Date: Sun, 12 Jan 2014 19:20:37 +0000
Subject: [PATCH v11 0/4] ARMv8 cpu topology
Message-ID: <1389554441-27335-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - A few trivial renames requested by Catalin
 - Pass cluster_id around by value outside of parse_cluster

   arm64: topology: Implement basic CPU topology support
   arm64: topology: Add support for topology DT bindings
   arm64: topology: Tell the scheduler about the relative
   arm64: topology: Provide relative power numbers for cores
