From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Feb 2016 11:47:19 +0800
Subject: [PATCH v2 05/10] regulator: axp20x: support AXP809 variant
In-Reply-To: <20160215200439.GC18327@sirena.org.uk>
References: <1455532288-30870-1-git-send-email-wens@csie.org>
 <1455532288-30870-6-git-send-email-wens@csie.org>
 <20160215200439.GC18327@sirena.org.uk>
Message-ID: <CAGb2v671L47bCKowPF7BcjZWGbewLKzg-r+FtFYt3J11YE4KjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 4:04 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 15, 2016 at 06:31:23PM +0800, Chen-Yu Tsai wrote:
>> The X-Powers AXP809 PMIC has a similar set of regulators as the AXP221,
>> though a few LDOs were removed, and a new switch output added. Like the
>> AXP221, AXP809 also has DC1SW and DC5LDO, which are internally chained
>> to DCDC1 and DCDC5, respectively.
>
> This doesn't apply against current code, please check and resend.

This requires mfd/ib-mfd-regulator-4.6 from Lee's tree to apply cleanly,
and "mfd: axp20x: Add support for AXP809 PMIC", which isn't merged yet,
to compile.

ChenYu
