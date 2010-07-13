From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:15 +0800
Subject: [RFC PATCH 0/13] Misc cleanup patches to prepare for unified zImage
Message-ID: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ideas when converting those conflicting symbols:

1. Keep the original one as much as possible
2. Introduce an alternative global variable when it's not already defined
3. Kconfig option to control if header file needs to be included (if no
   other way around)

Preliminary at this moment, just RFC.
