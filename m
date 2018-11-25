From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 25 Nov 2018 18:55:01 -0200
Subject: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Remove CONFIG_ARM_UNWIND
In-Reply-To: <CAP9ODKrpde0tpRgoRMihvDur=ftQsT59h4Cqr3VQAOOimoSB1Q@mail.gmail.com>
References: <20181125201729.19836-1-otavio@ossystems.com.br>
 <CAOMZO5AVWbk_gdtDvXQfYqmENr8d3z5oxQVtzFtex0WrfY6tZQ@mail.gmail.com>
 <CAP9ODKrpde0tpRgoRMihvDur=ftQsT59h4Cqr3VQAOOimoSB1Q@mail.gmail.com>
Message-ID: <CAOMZO5APMEksc3B0pxGzaEGMuwqC+TeuBcdhUSqR1+M7VOdTKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Otavio,

On Sun, Nov 25, 2018 at 6:49 PM Otavio Salvador
<otavio.salvador@ossystems.com.br> wrote:

> In fact, was removed and now selected.

Yes, correct. In 4.20-rc1 this option is automatically selected.

> I changed the commit log as:
>
> ARM: imx_v6_v7_defconfig: Remove explicit ARM_UNWIND disable
>
> CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> selected by the Kconfig logic.  This is done in preparation to making
> further changes to this defconfig cleaner.
>
> Do you agree?

Looks good to me, thanks.
