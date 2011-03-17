From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Mar 2011 09:58:21 +0100
Subject: [PATCH 1/4] amba: add name based matching
In-Reply-To: <20110317084858.GB29758@n2100.arm.linux.org.uk>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
	<1300200116-12185-2-git-send-email-philippe.langlais@stericsson.com>
	<20110315144925.GG3921@n2100.arm.linux.org.uk>
	<AANLkTinrVeaGXhE8mUqMJCw0fzeEB7Ko+p6ViD3JWePX@mail.gmail.com>
	<20110317084858.GB29758@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimrez46PsnfRzh-j8-ONFBV5mu_KywhvX=3UeDy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 9:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> This means we don't pick up on the hardware configuration when platforms
> have set the ID, and since we always provide the ID that would be bad.

Yes, so I don't put in this one patch, but also take a grep
and check through the kernel tree and try to find and eleminate those, so
that the possibility of hardcoding the ID is only used when it is proper,
i.e. when it should have been something else than what is in the hardware.

Yours,
Linus Walleij
