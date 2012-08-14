From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:32:02 +0200
Subject: [rtc-linux] [PATCH 1/1] drivers/rtc/rtc-ab8500.c: Revoke Device
 Tree enablement
In-Reply-To: <1344527828-6283-3-git-send-email-lee.jones@linaro.org>
References: <1344527828-6283-1-git-send-email-lee.jones@linaro.org>
 <1344527828-6283-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZa-72QogrZ-P5jbDHTTX64babZo3ydjzfgC-4LWUBfMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:57 PM, Lee Jones <lee.jones@linaro.org> wrote:

> All AB8500 devices are now registered via MFD core, so Device Tree
> capability is no longer required for probing. Here we pull the DT
> match table to ensure we're no longer probed during Device Tree
> start-up.
>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: rtc-linux at googlegroups.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
