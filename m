From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 08 Oct 2015 15:45:22 +0300
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <20151008123630.GC20936@cbox>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
 <003a01d10199$58e96590$0abc30b0$@samsung.com> <20151008082302.GE14315@cbox>
 <005e01d101a9$31ee80f0$95cb82d0$@samsung.com> <20151008092858.GA16100@cbox>
 <561641F5.4060202@arm.com> <009501d101c4$dde8e2e0$99baa8a0$@samsung.com>
 <20151008123630.GC20936@cbox>
Message-ID: <009901d101c7$3331b3b0$99951b10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> There's no rush, I don't think this will make it into v4.4 anyhow

 Did you mean 4.3 here?

> Speaking of which, does the QEMU side of this patch set require first
> adding the GICv3 emulation for the data structures or is there a
> stand-alone migration patch set somewhere?

 I rolled it out a week ago: https://www.mail-archive.com/qemu-devel at nongnu.org/msg325331.html. I
tried to get reviewed/accepted/whatever at least data structure part, but Peter replied that he
isn't interested before we have the kernel.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
