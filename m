From: t.dakhran@gmail.com (Tarek Dakhran)
Date: Mon, 18 May 2015 10:31:37 +0300
Subject: [PATCH v1 1/1] ARM: EXYNOS: fix DEBUG_LL on Cortex-A7.
In-Reply-To: <CAPTzV17YWyTiFU4wGs=Wy9quC_NzguXuqrheY_JoqAWN=VRniA@mail.gmail.com>
References: <1431844923-4654-1-git-send-email-t.dakhran@gmail.com>
 <1431844923-4654-2-git-send-email-t.dakhran@gmail.com>
 <CAPTzV17YWyTiFU4wGs=Wy9quC_NzguXuqrheY_JoqAWN=VRniA@mail.gmail.com>
Message-ID: <CANhyOUe1+YKzkfFqZVzuj2yNj+wdFb+hRHPjk2kwqGrwtkxtOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

On Mon, May 18, 2015 at 4:52 AM, Chanho Park <parkch98@gmail.com> wrote:
>
> Please see previous Joonyoung's patch. Your patch could break
> exynos3250 because it has not only two cortex-a7 cpus but also uses
> EXYOS4_PA_UART.
>
> http://www.spinics.net/lists/linux-samsung-soc/msg37318.html
>

Thanks, Joonyoung's patch works for me and it seems really reasonable
to check cluster id.

Best regards,
     Tarek
