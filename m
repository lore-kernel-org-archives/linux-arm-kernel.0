From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Fri, 11 Aug 2017 13:49:59 +0200
Subject: [PATCH 0/2] More s5p-jpeg fixes
In-Reply-To: <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
References: <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170811115011eucas1p2d31daaa9e6f8d142291d9352ad5b732c@eucas1p2.samsung.com>
Message-ID: <1502452201-17171-1-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The first patch in the series fixes decoding path,
the second patch fixes encoding path. Please see
appropriate commit messages.

Andrzej Pietrasiewicz (2):
  media: s5p-jpeg: don't overwrite result's "size" member
  media: s5p-jpeg: set w/h when encoding

 drivers/media/platform/s5p-jpeg/jpeg-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
1.9.1
