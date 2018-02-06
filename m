From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Feb 2018 15:08:01 -0200
Subject: [PATCHv2 2/3] ARM: imx53: add SoC specific PMU setup
In-Reply-To: <20180206142629.534-3-sebastian.reichel@collabora.co.uk>
References: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
 <20180206142629.534-3-sebastian.reichel@collabora.co.uk>
Message-ID: <CAOMZO5DYiFg0T9Byd5cbJKXbFHmO7d1-T0KnMVKhn03nqRm0Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 6, 2018 at 12:26 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> From: Peter Senna Tschudin <peter.senna@collabora.com>

Looking at http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277931.html
this patch seems to be originally from Martin Fuzzey.

In this case I would expect to see his name in the From field.

Please check the same on the other patches.

> On i.MX53 it is necessary to set the DBG_EN bit in the
> platform GPC register to enable access to PMU counters
> other than the cycle counter.
>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
