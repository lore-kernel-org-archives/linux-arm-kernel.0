From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed, 17 Apr 2013 10:39:46 +0200
Subject: [PATCH v2 0/7] pcmcia: at91_cf: clean up and add DT support
In-Reply-To: <cover.1363865228.git.nicolas.ferre@atmel.com>
References: <cover.1363865228.git.nicolas.ferre@atmel.com>
Message-ID: <CAHkwnC-aL=G9K9jttjD8Bk_ZKJ535vsGT26uCFbuFMeJUquYQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 12:40 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> These patches clean up at91_cf a bit and add DT bindings.
> It is based on a previous series from Joachim Eastwood and other cleanup
> patches by Fabio and Laurent.
> I have collected them together as they are lying around for some time.
>
> Please tell me if It can go through PCMCIA tree or if Andrew or Greg can
> take them.
> Note that they are not bug fixes, so you can stack them for 3.10.
>
> Thanks for your help, best regards.
>
> v2: add 2 more cleanup patches:
>         - move to module_platform_driver_probe()
>         - little trivial indentation fix
>
> Fabio Porcedda (1):
>   pcmcia: at91_cf: use module_platform_driver_probe()
>
> Joachim Eastwood (5):
>   pcmcia: at91_cf: fix gpio_get_value in at91_cf_get_status
>   pcmcia: at91_cf: convert to dev_ print functions
>   pcmcia: at91_cf: use devm_ functions for allocations
>   pcmcia: at91_cf: clean up header includes
>   pcmcia: at91_cf: add support for DT
>
> Laurent Navet (1):
>   pcmcia/trivial: at91_cf: fix checkpatch error
>
>  .../devicetree/bindings/ata/atmel-at91_cf.txt      |  19 +++
>  drivers/pcmcia/Kconfig                             |   2 +-
>  drivers/pcmcia/at91_cf.c                           | 176 ++++++++++-----------
>  3 files changed, 108 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
>
> --
> 1.8.0
>

Ping?

Regards
--
Fabio Porcedda
