From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  4 Mar 2015 12:23:14 +0100
Subject: [PATCH v2 0/3] arm64: head.S cleanup
Message-ID: <1425468197-22377-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This some janitorial work on head.S, just stuff I noticed when making
changes to it for other reasons.

Some may find the churn pointless, but my opinion is that .S files -if they
cannot be avoided in the first place- should be as simple and straightforward
as possible.

Ard Biesheuvel (3):
  arm64: remove processor_id
  arm64: remove __switch_data object from head.S
  arm64: remove __lookup_processor_type_data, object from head.S

 arch/arm64/kernel/head.S  | 58 ++++++++++++++---------------------------------
 arch/arm64/kernel/setup.c |  3 ---
 2 files changed, 17 insertions(+), 44 deletions(-)

-- 
1.8.3.2
