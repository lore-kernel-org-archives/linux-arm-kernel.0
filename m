From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 09 Oct 2015 11:10:29 +0300
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <56177592.2080702@arm.com>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
 <00e601d10264$61cdafb0$25690f10$@samsung.com> <56177592.2080702@arm.com>
Message-ID: <00ec01d10269$f6c82af0$e45880d0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> How do you reconcile the two? What's the point of trying to shoehorn a
> different concept into the existing API?

 Keeping amount of #define's as small as possible, and try to reuse everything that can be reused.
 It's just my personal taste, nothing serious. :) The question was just a clarification. Ok, this is
not a problem. By the way, i've just finished v5 patchset, now need to rewrite qemu and test before
posting it.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
