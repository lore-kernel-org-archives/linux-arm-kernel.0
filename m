From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 08 Oct 2015 15:28:40 +0300
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <561641F5.4060202@arm.com>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
 <003a01d10199$58e96590$0abc30b0$@samsung.com> <20151008082302.GE14315@cbox>
 <005e01d101a9$31ee80f0$95cb82d0$@samsung.com> <20151008092858.GA16100@cbox>
 <561641F5.4060202@arm.com>
Message-ID: <009501d101c4$dde8e2e0$99baa8a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> Well, compatibility with GICv2 is the biggest mistake we made when
> designing the GICv3 architecture. And that's why our emulation doesn't
> give a damn about v2 compatibility.

 Ok, i see your arguments, and after that it becomes a matter of personal taste. Three beat one, i
go your way. :) Don't know if i'll be able to roll out v5 tomorrow, but i think on monday i'll
definitely do.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
