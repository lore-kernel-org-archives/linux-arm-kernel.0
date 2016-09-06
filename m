From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 6 Sep 2016 09:12:10 +0100
Subject: [PATCH v2 3/8] regulator: axp20x: support AXP806 variant
In-Reply-To: <CAGb2v65Fs+KjVjWB_PhSmT_zdVYFTHZoc9fGeo0D3QuwwVgx4w@mail.gmail.com>
References: <20160827075544.26316-1-wens@csie.org>
 <20160827075544.26316-4-wens@csie.org>
 <20160901202340.GT5967@sirena.org.uk>
 <CAGb2v65Fs+KjVjWB_PhSmT_zdVYFTHZoc9fGeo0D3QuwwVgx4w@mail.gmail.com>
Message-ID: <20160906081210.GV4921@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Sep 2016, Chen-Yu Tsai wrote:
> On Fri, Sep 2, 2016 at 4:23 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Sat, Aug 27, 2016 at 03:55:39PM +0800, Chen-Yu Tsai wrote:
> >> The X-Powers AXP806 PMIC has a new set of buck and LDO regulators, and
> >> also a switch. The buck regulators support teaming into multi-phase
> >> groups, with A+B, A+B+C, D+E groupings.
> >
> > Acked-by: Mark Brown <broonie@kernel.org>
> 
> Could you merge this through the mfd tree, along with the AXP806
> mfd patches?

Yes, I've marked this patch as "TODO".  Leave it with me.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
