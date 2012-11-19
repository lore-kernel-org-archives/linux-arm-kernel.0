From: rajanikanth.hv@linaro.org (Rajanikanth HV)
Date: Mon, 19 Nov 2012 09:28:59 +0530
Subject: [PATCH 0/4] Implement device tree support for ab8500 BM Devices
In-Reply-To: <20121119034600.GP29066@lizard.sbx05977.paloaca.wayport.net>
References: <1351698033-8980-1-git-send-email-rajanikanth.hv@linaro.org>
 <20121119034600.GP29066@lizard.sbx05977.paloaca.wayport.net>
Message-ID: <CAB4BAkvXZacDVZh2gzooH-Eq8Vnc8JLd=v8=9p-4mLfY0qWavw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 19 November 2012 09:16, Anton Vorontsov <anton.vorontsov@linaro.org> wrote:
> (But I'm bouncing the patches to Samuel and Mark anyway, jfyi.)
>
> p.s.
>
> FWIW, I fixed these warnings.
>
>   CHECK   drivers/power/ab8500_bmdata.c
> drivers/power/ab8500_bmdata.c:146:23: warning: symbol 'temp_to_batres_tbl_thermistor' was not declared. Should it be static?
> drivers/power/ab8500_bmdata.c:160:23: warning: symbol 'temp_to_batres_tbl_ext_thermistor' was not declared. Should it be static?
> drivers/power/ab8500_bmdata.c:171:23: warning: symbol 'temp_to_batres_tbl_9100' was not declared. Should it be static?
> drivers/power/ab8500_bmdata.c:181:28: warning: symbol 'bat_type_thermistor' was not declared. Should it be static?
> drivers/power/ab8500_bmdata.c:267:28: warning: symbol 'bat_type_ext_thermistor' was not declared. Should it be static?
>
> Plus fixed a few stylistic issues.

thanks anton for validating my patch, you seems to have older version
of patch set,
i am rebasing  new version of patch set to 3.7-rc5, will communicate asap.
