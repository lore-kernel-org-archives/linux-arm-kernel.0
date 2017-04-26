From: kvalo@codeaurora.org (Kalle Valo)
Date: Wed, 26 Apr 2017 09:03:05 +0000 (UTC)
Subject: [1/1] mt7601u: check return value of alloc_skb
In-Reply-To: <1492930823-17249-1-git-send-email-bianpan2016@163.com>
References: <1492930823-17249-1-git-send-email-bianpan2016@163.com>
Message-ID: <20170426090305.082D761493@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pan Bian <bianpan2016@163.com> wrote:
> Function alloc_skb() will return a NULL pointer if there is no enough
> memory. However, in function mt7601u_mcu_msg_alloc(), its return value
> is not validated before it is used. This patch fixes it.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

5fb01e91daf8 mt7601u: check return value of alloc_skb

-- 
https://patchwork.kernel.org/patch/9694549/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
