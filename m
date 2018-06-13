From: dolinux.peng@gmail.com (Peng Donglin)
Date: Wed, 13 Jun 2018 09:11:57 +0800
Subject: [PATCH 0/2] Re-use DEFINE_SHOW_ATTRIBUTE() macro
In-Reply-To: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
References: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
Message-ID: <cover.1528819790.git.dolinux.peng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

Peng Donglin (2):
  ARM: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro
  ARM64: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro

 arch/arm/mm/ptdump_debugfs.c   | 13 +------------
 arch/arm64/mm/ptdump_debugfs.c | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

-- 
2.7.4
