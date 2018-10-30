From: sean.wang@kernel.org (Sean Wang)
Date: Tue, 30 Oct 2018 16:45:52 -0700
Subject: [PATCH 5/5] pinctrl: mediatek: Add initial pinctrl driver for
 MT6797 SoC
In-Reply-To: <CACRpkdb-Er8z6JdvYWE8UXUa3dfVSu4S-VbnqvcV+vf9erJuNw@mail.gmail.com>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-6-manivannan.sadhasivam@linaro.org>
 <c8d65395-c60c-5d06-92ad-c389642c22ba@gmail.com>
 <20181011164429.GA18174@Mani-XPS-13-9360>
 <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
 <CAGp9LzoP2zkryhJCQNGpe9X0+7yUd31ffV7vM4j6KvTdfPpCrA@mail.gmail.com>
 <CACRpkdb-Er8z6JdvYWE8UXUa3dfVSu4S-VbnqvcV+vf9erJuNw@mail.gmail.com>
Message-ID: <CAGp9LzpssWX2TxPdD0yWtmav2XGdG68ztx+hV1DxjRX52q0qvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sure, the version of driver looked good to me, add the missing Acked-by from me

Acked-by: Sean Wang <sean.wang@kernel.org>


On Tue, Oct 30, 2018 at 5:51 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Oct 18, 2018 at 5:06 PM Sean Wang <sean.wang@kernel.org> wrote:
>
> > the driver currently only supports the basic operation, not including
> > driving operation, so
> > what value for the driving mode for a certain pin seems not really
> > matter in the early patch. I think these advanced operations can be
> > added with another patch.
>
> Sean can you provide an Acked-by for the pinctrl part so I can merge
> it once Manivannan resends it for v4.21?
>
> Yours,
> Linus Walleij
