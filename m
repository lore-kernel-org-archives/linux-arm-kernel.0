From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Oct 2018 12:17:37 +0800
Subject: [PATCH v4 7/7] mfd: axp20x: Add supported cells for AXP803
In-Reply-To: <20181013080848.29894-8-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
 <20181013080848.29894-8-oskari@lemmela.net>
Message-ID: <CAGb2v66aJUYOkZL=b5TfnvLsbLk_mU8AQtR3BSBRM-49rh2yOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 is compatible with AXP813.
> Adding cells for GPIO, ADC, AC and battery power supplies.

They are not _completely_ compatible. A better way to phrase this would be:

Parts of the AXP803 are compatible with their counterparts on the AXP813.
These include the GPIO, ADC, AC and battery power supplies.

> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
