From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 15 Oct 2013 23:31:36 -0700
Subject: [PATCH] input: qt1070: add power management ops
In-Reply-To: <525B84F4.4000405@atmel.com>
References: <1376379826-28808-1-git-send-email-voice.shen@atmel.com>
 <520B2921.3000906@atmel.com> <525B84F4.4000405@atmel.com>
Message-ID: <20131016063136.GB4282@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bo,

On Mon, Oct 14, 2013 at 01:45:24PM +0800, Bo Shen wrote:
> Hi Dmitry,
> 
> On 8/14/2013 14:52, Nicolas Ferre wrote:
> >On 13/08/2013 09:43, Bo Shen :
> >>Add power management ops for qt1070, it maybe a wakeup source
> >>
> >>Signed-off-by: Bo Shen <voice.shen@atmel.com>
> >
> >Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Would this patch be applied with Nicolas' ACK?

This patch is already in mainline:

commit 3719b54bc62318db7dd8ac7c39a09dfb991a208f
Author: Bo Shen <voice.shen@atmel.com>
Date:   Tue Aug 13 09:46:40 2013 -0700

    Input: qt1070 - add power management ops

    Add power management ops for qt1070, it may be a wakeup source.

    Signed-off-by: Bo Shen <voice.shen@atmel.com>
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
