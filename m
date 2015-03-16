From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 Mar 2015 10:07:24 +0100
Subject: [PATCH 9/9] Revert "PM / Domains: Power on the PM domain right
 after attach completes"
In-Reply-To: <1426261429-31883-10-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <1426261429-31883-10-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdXYt8JwaUg1DPey7DTqGS_oOKDDeCOu5ojnQns8822TFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 4:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Due to the invent of dev_pm_domain_get|put() API and related code in the
> generic PM domain, we can now safely revert this commit.

... revert commit 2ed127697eb13766 ("PM / Domains: Power on the PM domain
right after attach completes").

So not everyone has to look for the commit ID.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
