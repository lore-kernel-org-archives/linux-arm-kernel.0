From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 18 Jun 2015 18:48:35 -0700
Subject: [PATCH 6/7] ARM: brcmstb: mask GIC IRQs on suspend
In-Reply-To: <1434672696-13632-7-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
 <1434672696-13632-7-git-send-email-computersforpeace@gmail.com>
Message-ID: <CADtm3G5arLABYkdKrgcKAagZRfSm_XwQO6UYfJH+ceijYuP39w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 5:11 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> Lazily-masked IRQs can cause system suspend problems (e.g., spurious
> wakeups from WFI), so we need to be sure non-wakeup GIC interrupts get
> masked, not just disabled, during system suspend.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
