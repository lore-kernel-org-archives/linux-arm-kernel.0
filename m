From: yifanlu@stanford.edu (Yifan Lu)
Date: Thu, 21 May 2015 23:46:00 -0700
Subject: Question on why specific ELF relocations are supported for module
 loader
Message-ID: <2A1C86A3-CCBE-4D59-88DF-910A2562D0E0@stanford.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm referring to linux/arch/arm/kernel/module.c. It seems to be an arbitrary subset of ARM ELF relocations. (The manual lists about 130 types of relocations.) Is it because GCC only outputs these types? Or is there another reason? Also, isn't static relocations only used for static linking?
