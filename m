From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 16 Feb 2012 23:27:14 +0800
Subject: [PATCH] arch/arm/mach-mmp/: some files include some headers twice
In-Reply-To: <1329403520-32551-1-git-send-email-danny.kukawka@bisect.de>
References: <1329403520-32551-1-git-send-email-danny.kukawka@bisect.de>
Message-ID: <CAN1soZyGoVA8A1BKyh73EHDxoR-St8g9eM1QOWLqp1+H2r0dXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 10:45 PM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
> arch/arm/mach-mmp/: some files include some headers twice:
> - arch/arm/mach-mmp/aspenite.c and
> ?arch/arm/mach-mmp/tavorevb.c: 'linux/gpio.h'
> - arch/arm/mach-mmp/pxa168.c: 'linux/platform_device.h'
>
> Remove the duplicates.
>
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Applied. Thanks
