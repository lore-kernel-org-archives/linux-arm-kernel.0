From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 12:03:22 +0800
Subject: [PATCH v2 3/8] regulator: axp20x: support AXP806 variant
In-Reply-To: <20160901202340.GT5967@sirena.org.uk>
References: <20160827075544.26316-1-wens@csie.org>
 <20160827075544.26316-4-wens@csie.org>
 <20160901202340.GT5967@sirena.org.uk>
Message-ID: <CAGb2v65Fs+KjVjWB_PhSmT_zdVYFTHZoc9fGeo0D3QuwwVgx4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Sep 2, 2016 at 4:23 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Aug 27, 2016 at 03:55:39PM +0800, Chen-Yu Tsai wrote:
>> The X-Powers AXP806 PMIC has a new set of buck and LDO regulators, and
>> also a switch. The buck regulators support teaming into multi-phase
>> groups, with A+B, A+B+C, D+E groupings.
>
> Acked-by: Mark Brown <broonie@kernel.org>

Could you merge this through the mfd tree, along with the AXP806
mfd patches?

Thanks
ChenYu
