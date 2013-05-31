From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 31 May 2013 17:10:45 +0800
Subject: [PATCH V1] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <20130531084703.GC4928@mudshark.cambridge.arm.com>
References: <1369839416-27817-1-git-send-email-ming.lei@canonical.com>
 <20130530154047.GW7483@mudshark.cambridge.arm.com>
 <CACVXFVNL032TY7b=YHEg9aaT_WNW3R8JOzaVqSbq09t2kcVOQg@mail.gmail.com>
 <20130531084703.GC4928@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNivgi8RdjX8iabcrh2ed7ddfdsUK_vmm1_MYNFONzQUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 4:47 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> I think it makes the code clearer and removes a check, so yes please.

No problem, will do it in v2.


Thanks,
--
Ming Lei
