From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:38:25 -0800
Subject: [PATCH v2 0/2] Add version macros for clang
In-Reply-To: <20171129000011.55235-1-samitolvanen@google.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
Message-ID: <20171130233827.130069-1-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds macros for checking clang version.

Changes from v1:
  - fixed a comment in clang-version.sh
  - renamed macros to __cc-ifversion and __cc-if-fullversion
  - fixed a bug with non-bash shells
  - dropped the arm64 patch as unnecessary

Sami Tolvanen (2):
  kbuild: add clang-version.sh
  kbuild: add __cc-ifversion and compiler-specific variants

 scripts/Kbuild.include   | 41 ++++++++++++++++++++++++++++++++++-------
 scripts/clang-version.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 7 deletions(-)
 create mode 100755 scripts/clang-version.sh

-- 
2.15.0.531.g2ccb3012c9-goog
