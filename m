From: biao.huang@mediatek.com (Biao Huang)
Date: Fri, 16 Nov 2018 17:26:15 +0800
Subject: [v3, PATCH 0/2] add Ethernet driver support for mt2712
Message-ID: <1542360377-29047-1-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

modifications according to comments from Corentin and Andrew:
1. fix comment style
2. add COMPILE_TEST || ARCH_MEDIATEK in Kconfig file
3. replace pr_err with dev_err
4. add binding document for properties: tx-delay/rx-delay/fine-tune etc.
