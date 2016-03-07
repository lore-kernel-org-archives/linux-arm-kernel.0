From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 7 Mar 2016 11:38:36 +0900
Subject: [PATCH] ARM: dma-mapping: remove arm_dma_set_mask()
In-Reply-To: <1456475762-29511-1-git-send-email-acourbot@nvidia.com>
References: <1456475762-29511-1-git-send-email-acourbot@nvidia.com>
Message-ID: <CAAVeFu+tp-Dac729s+pFB30LQcwty2RBTYDCECRQHXm4cUiSgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 5:36 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> arm_dma_set_mask() implements exactly the same behavior as the fallback
> that dma_set_mask() takes if the set_dma_mask op is not set. Remove it
> and use that fallback instead like the dma_get_mask() counterpart
> already does.

No one got mad at this so I took the freedom to send it to Russell's
patch tracking system.
