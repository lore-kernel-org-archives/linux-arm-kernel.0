From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 02 Jul 2015 09:45:00 +0300
Subject: [PATCH 4/4] irqchip, gicv3-its: Implement Cavium ThunderX errata
 22375, 24313
In-Reply-To: <559404D1.3030909@arm.com>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
 <1435673643-31676-5-git-send-email-rric@kernel.org>
 <023101d0b402$eba41e00$c2ec5a00$@samsung.com> <559404D1.3030909@arm.com>
Message-ID: <00c601d0b492$9eda83d0$dc8f8b70$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> What makes you think that an entry in the device table is the same size
> as a translation entry? Just because one contains a pointer to the other
> doesn't imply they have the same size.

 Oops... I didn't have GICv3 arch reference manual back then, so i was confused. Ignore this then.
:)

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
