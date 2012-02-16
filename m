From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 16 Feb 2012 23:26:45 +0800
Subject: [PATCH] arch/arm/mach-pxa/: included linux/gpio.h twice
In-Reply-To: <1329403542-32606-1-git-send-email-danny.kukawka@bisect.de>
References: <1329403542-32606-1-git-send-email-danny.kukawka@bisect.de>
Message-ID: <CAN1soZzQyQpC4V0HhfpA6gGfziBBEEnW=f60YAKjmbKW4APs=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 10:45 PM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
> arch/arm/mach-pxa/pxa25x.c and arch/arm/mach-pxa/saarb.c
> included 'linux/gpio.h' twice, remove the duplicates.
>
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
> ---
> ?arch/arm/mach-pxa/pxa25x.c | ? ?1 -
> ?arch/arm/mach-pxa/saarb.c ?| ? ?1 -
> ?2 files changed, 0 insertions(+), 2 deletions(-)
>
Applied. Thanks
