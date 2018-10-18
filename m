From: shyam.saini@amarulasolutions.com (Shyam Saini)
Date: Thu, 18 Oct 2018 20:28:32 +0530
Subject: [PATCH] ARM: dts: imx: Add missing stdout-path property
In-Reply-To: <CAOMZO5Di60q+ma2ASe-PbSitAPMEBvWN1Sa2uQY6CKN6rEkSgg@mail.gmail.com>
References: <20181018145128.21117-1-shyam.saini@amarulasolutions.com>
 <CAOMZO5Di60q+ma2ASe-PbSitAPMEBvWN1Sa2uQY6CKN6rEkSgg@mail.gmail.com>
Message-ID: <CA+drQ_PHmKCbmfW9HMSpzMsd+W22mhMCL7cj=+WJA8zN=n-C_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> On Thu, Oct 18, 2018 at 11:52 AM Shyam Saini
> <shyam.saini@amarulasolutions.com> wrote:
> >
> > This would help us to get early boot logs by passing "earlycon" to
> > kernel bootargs.
> >
> > Further, by adding this we don't have to depend on complex earlyprintk
> > configs for early boot logs.
> >
> > Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
>
> In the Subject please mention the board name:

Thanks Fabio for your suggestion.
I'll resend the V2 with changes.
