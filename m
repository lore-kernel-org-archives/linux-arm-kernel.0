From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 11:43:22 +0300
Subject: [PATCH] ARM: exynos: Bring back reboot on Exynos5410
In-Reply-To: <5631D8E5.6090506@samsung.com>
References: <1446024965-8508-1-git-send-email-p.fedin@samsung.com>
 <56317960.9070608@samsung.com>
 <CAGcde9H4WVt34rn6_9H+sVu2Bp2xq4awMiwV1zgv1D6posPWSg@mail.gmail.com>
 <006c01d11218$d6e2d500$84a87f00$@samsung.com> <5631D8E5.6090506@samsung.com>
Message-ID: <002801d11225$dedab4a0$9c901de0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> These patches are not adding any new code, except DT entry. Infact
> restart handler will be removed from PMU driver and we will be using
> generic syscon based implementation for reboot, which is already present
> in Linux kernel.

 Ah, got it. So syscon is a very generic thing, allowing to describe whatever reset register for whatever board, since we are specifying both address and value to write there. Is my understanding correct? If so, then, OK, you can do this too.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
