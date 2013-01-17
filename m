From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Jan 2013 00:27:10 -0200
Subject: [PATCH v4] video: imxfb: Do not crash on reboot
In-Reply-To: <20130117021708.GE26179@S2101-09.ap.freescale.net>
References: <1358341121-19480-1-git-send-email-fabio.estevam@freescale.com>
 <20130117021708.GE26179@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5B-wT-Hm0oFnvVhGif3aornpecsqrF-wFG_CLwkF6YabA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 12:17 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Jan 16, 2013 at 10:58:41AM -0200, Fabio Estevam wrote:
>> Shawn,
>>
>> Since you have taken a patch recently that touches this file and given the fact
>> that we have zero response from the fb maintainer, can you please apply it via
>> imx tree?
>
> Ok, I will queue it as the 3rd batch of fixes to be sent next week.
>
> Is it a material for stable tree?

It could be sent to stable, but this patch does not apply to stable
because stable tree does not have your commit:

commit e69dc9a91eeb0387e08d8e1d0e576c88b28902fc
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Sun Sep 16 19:59:53 2012 +0800

    video: imxfb: remove cpu_is_xxx by using platform_device_id
