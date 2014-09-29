From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 15:35:09 +0200
Subject: [PATCH v11 6/6] arm: KVM: ARMv7 dirty page logging 2nd stage
 page fault
In-Reply-To: <1411433690-8104-7-git-send-email-m.smarduch@samsung.com>
References: <1411433690-8104-1-git-send-email-m.smarduch@samsung.com>
 <1411433690-8104-7-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140929133509.GH3095@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 05:54:50PM -0700, Mario Smarduch wrote:
> This patch adds support for handling 2nd stage page faults during migration,
> it disables faulting in huge pages, and dissolves huge pages to page tables.
> In case migration is canceled huge pages may be used again.
> 
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

It seems here and in a bunch of the other patches you didn't apply my
Reviewed-by tags.  Did you change the patches in other ways than
addressed by the review comments?

Thanks,
-Christoffer
