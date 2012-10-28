From: marex@denx.de (Marek Vasut)
Date: Sun, 28 Oct 2012 23:01:45 +0100
Subject: [PATCH 5/5] ARM: PXA: Zipit Z2: Fix backlight PWM device number
In-Reply-To: <1351438555-4668-5-git-send-email-anarsoul@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-5-git-send-email-anarsoul@gmail.com>
Message-ID: <201210282301.45790.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Vasily Khoruzhick,

> Recent changes to PXA PWM support changed the PXA27X PWM device
> numbering scheme, so keyboard and LCD backlight is not
> working anymore on Z2.
> 
> Fix it and move from legacy to new PWM API.

The proper fix here would be to start moving towards DT.

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
[...]

Best regards,
Marek Vasut
