From: amit.shah@redhat.com (Amit Shah)
Date: Thu, 16 May 2013 18:07:46 +0530
Subject: [PATCH V2 1/3] virtio: console: Add emergency writeonly register
 to config space
In-Reply-To: <1367842791-30285-2-git-send-email-pranavkumar@linaro.org>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-2-git-send-email-pranavkumar@linaro.org>
Message-ID: <20130516123746.GA4744@amit.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (Mon) 06 May 2013 [17:49:49], Pranavkumar Sawargaonkar wrote:
> This patch adds an emerg_wr register (writeonly) in config space
> of virtio console device which can be used for debugging.
> 
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

OK, this change by itself looks harmless.

Acked-by: Amit Shah <amit.shah@redhat.com>

		Amit
