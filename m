From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 2 Oct 2018 17:08:49 +0200
Subject: [PATCH v7 2/4] clk: davinci: kill
 davinci_clk_reset_assert/deassert()
In-Reply-To: <160f4225-236c-af54-9693-120e834af578@lechnology.com>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <20180621073706.22812-3-brgl@bgdev.pl>
 <160f4225-236c-af54-9693-120e834af578@lechnology.com>
Message-ID: <CAMRc=McmwWt5OdCxGntDJ-5cxte+Ad2FJcnmWT8NxnBtzP40DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pt., 6 lip 2018 o 19:54 David Lechner <david@lechnology.com> napisa?(a):
>
> On 06/21/2018 02:37 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This code is no longer used. Remove it.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: David Lechner <david@lechnology.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>
> I've picked this up in clk-davinci-4.20, so it will just hang out
> there for a while until the rest of this series gets merged.
>

Hi David,

I don't see this patch in next yet. Is it queued for 4.20?

Thanks in advance,
Bartosz
