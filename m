From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 Dec 2014 09:35:09 +0100
Subject: [RFC PATCH 2/2] iommu: rockchip: Handle system-wide and runtime PM
In-Reply-To: <7ha92sk533.fsf@deeprootsystems.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
 <7h8uiemce7.fsf@deeprootsystems.com>
 <CAPDyKFo6zH4__Odm+RiJCbvXquAQqaLyCAiXrSN6s3KfQhok=A@mail.gmail.com>
 <1576771.dIVCOxU0se@vostro.rjw.lan>
 <CAAFQd5B28WiWUqmbmROJUa3H25R=Y774NuemTZDvkoa=CvZUsw@mail.gmail.com>
 <7ha92sk533.fsf@deeprootsystems.com>
Message-ID: <CAMuHMdVpCgK-hNqZ=JWjFGS53g+ZUQ5t=uBxtN1qGXJhoRg8BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 9:04 PM, Kevin Hilman <khilman@kernel.org> wrote:
> An even more exciting problem exists when a CPU is in the same domain as
> other peripherals, those peripherals are all idle and the power domain
> is gated. :)

We do have pm_genpd_attach_cpuidle() and pm_genpd_name_attach_cpuidle()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
