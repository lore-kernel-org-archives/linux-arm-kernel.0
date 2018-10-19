From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 19 Oct 2018 16:57:04 +0300
Subject: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Message-ID: <CAHp75Vd_9RmfDFnSzkNOQyfKVOR1tfzbMPy0_J7_DfZ2e4A16g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi.
>
> This patchset adds support for the Embedded Controller on an OLPC XO
> 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> the existing OLPC platform infrastructure, currently used by the x86
> based models.
>
> The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> uses extra handshake signal to signal readiness of SOC to accept data
> from EC and to initiate a transaction if SOC wishes to submit data.
>
> The SPI slave support for MMP2 was submitted separately:
> https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak at v3.sk/T/#t
>

> THe "power: supply: olpc_battery: correct the temperature" patch was

The

> already sent out separately, but I'm including it because the last
> commit of the set depends on it.
>
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.
>
> Thanks in advance for reviews and feedback of any kind.

Thanks for the series.
I'm about to review the patch 6, otherwise read my comments for the
rest and consider addressing them.

>
> Lubo
>


-- 
With Best Regards,
Andy Shevchenko
