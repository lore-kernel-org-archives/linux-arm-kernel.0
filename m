From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sun, 18 Nov 2012 20:57:53 -0800
Subject: [PATCH 0/4] Implement device tree support for ab8500 BM Devices
In-Reply-To: <CAB4BAkvXZacDVZh2gzooH-Eq8Vnc8JLd=v8=9p-4mLfY0qWavw@mail.gmail.com>
References: <1351698033-8980-1-git-send-email-rajanikanth.hv@linaro.org>
 <20121119034600.GP29066@lizard.sbx05977.paloaca.wayport.net>
 <CAB4BAkvXZacDVZh2gzooH-Eq8Vnc8JLd=v8=9p-4mLfY0qWavw@mail.gmail.com>
Message-ID: <20121119045753.GA28159@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 09:28:59AM +0530, Rajanikanth HV wrote:
> > FWIW, I fixed these warnings.
> >
> >   CHECK   drivers/power/ab8500_bmdata.c
> > drivers/power/ab8500_bmdata.c:146:23: warning: symbol 'temp_to_batres_tbl_thermistor' was not declared. Should it be static?
> > drivers/power/ab8500_bmdata.c:160:23: warning: symbol 'temp_to_batres_tbl_ext_thermistor' was not declared. Should it be static?
> > drivers/power/ab8500_bmdata.c:171:23: warning: symbol 'temp_to_batres_tbl_9100' was not declared. Should it be static?
> > drivers/power/ab8500_bmdata.c:181:28: warning: symbol 'bat_type_thermistor' was not declared. Should it be static?
> > drivers/power/ab8500_bmdata.c:267:28: warning: symbol 'bat_type_ext_thermistor' was not declared. Should it be static?
> >
> > Plus fixed a few stylistic issues.
> 
> thanks anton for validating my patch, you seems to have older version
> of patch set,
> i am rebasing  new version of patch set to 3.7-rc5, will communicate asap.

Can you please rebase the new work on top of current battery tree (i.e. on
top of the patches that you've sent)? Or that would be too much burden?
