From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 30 Mar 2015 13:54:22 +0800
Subject: [PATCH v3] cpufreq: hisilicon: add acpu driver
In-Reply-To: <CAKohpomCQos+a8rjZa=B=jmhffi-qWrjz_nSZ_i68fxnJ5ioVA@mail.gmail.com>
References: <1427693197-12290-1-git-send-email-leo.yan@linaro.org>
 <CAKohpomCQos+a8rjZa=B=jmhffi-qWrjz_nSZ_i68fxnJ5ioVA@mail.gmail.com>
Message-ID: <20150330055422.GB30058@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 11:04:08AM +0530, Viresh Kumar wrote:
> On 30 March 2015 at 10:56, Leo Yan <leo.yan@linaro.org> wrote:
> > Add acpu driver for hisilicon SoC, acpu is application processor
> > subsystem. Currently the acpu has the coupled clock domain for two
> > clusters, so this driver will directly use cpufreq-dt driver as
> > backend.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm         |  9 ++++++++
> >  drivers/cpufreq/Makefile            |  1 +
> >  drivers/cpufreq/hisi-acpu-cpufreq.c | 42 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 52 insertions(+)
> >  create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, Viresh.
