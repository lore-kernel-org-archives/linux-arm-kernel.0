From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 10 Dec 2015 23:03:39 +0900
Subject: [PATCH v8 5/4] arm64: Fix off-by-one in stack tracing when
 stepping off irq stack
In-Reply-To: <1449742961-11432-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449742961-11432-1-git-send-email-james.morse@arm.com>
Message-ID: <27C55C8D-A1FA-4DB3-AD06-DE2D32A97FEF@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 10, 2015, at 7:22 PM, James Morse wrote:

Hi James,

> From: Jungseok Lee <jungseoklee85@gmail.com>

I'm satisfied with spotting the frame->sp issue ;) According to for-next/core
branch, Will have already worked on this change with an informative commit msg.

Thanks for your care!

Best Regards
Jungseok Lee
