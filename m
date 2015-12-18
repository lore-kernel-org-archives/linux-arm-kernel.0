From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2015 08:14:06 -0800
Subject: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
In-Reply-To: <CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
References: <1449528845-25189-1-git-send-email-tony@atomide.com>
 <CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
Message-ID: <20151218161406.GL23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [151207 16:20]:
> +Linus
> 
> On 7 December 2015 at 23:54, Tony Lindgren <tony@atomide.com> wrote:
> > Commit ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
> > changed the handling MMC power sequence so GPIOs no longer are optional.
> >
> > This broke SDIO WLAN at least for omap5 that can't yet use the reset GPIOs
> > with pwrseq_simple as a wait is needed after enabling the SDIO device.
> 
> Can you elaborate on this. Did it break omap5 or not? :-)

Ulf, is this patch queued for v4.4 as a regression fix? I don't see it
in Linux next or mainline trees?

Regards,

Tony
