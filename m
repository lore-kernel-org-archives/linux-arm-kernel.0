From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 25 Jun 2010 15:44:27 +0800
Subject: [PATCH 0/4] Allow absence of mach/io.h
Message-ID: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce USE_DEFAULT_IO_H to allow default definitions of

  IO_SPACE_LIMIT
  __mem_pci()
  __io()

And most SoC can actually use these default definitions without the
need to have a specific mach/io.h. PXA and MMP are two examples in
the last patch, where the files are removed.
