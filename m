From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 6 Feb 2015 10:35:55 +0800
Subject: [alsa-devel] [PATCH baohua] ASoC: sirf: atlas7:
 atlas7_iacc_dai_ops can be static
In-Reply-To: <20150205171159.GY21293@sirena.org.uk>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com>
 <20150205170352.GA49811@snb> <20150205171159.GY21293@sirena.org.uk>
Message-ID: <CAGsJ_4wWfRse_Ba5Xx7y07v7RvbQZ9++W9z2w0VDeLjbenoqsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-06 1:11 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Fri, Feb 06, 2015 at 01:03:52AM +0800, kbuild test robot wrote:
>> sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?
>
> This file isn't in an upstream tree, should this patch have been sent
> upstream (I suspect non-upstream trees may need a bit of filtering in
> the scripts)?

the file is new and under developing. so no patch for it yet. is it
possible to modify kbuild script?

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-barry
