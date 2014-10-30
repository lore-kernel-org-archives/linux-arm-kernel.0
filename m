From: addy.ke@rock-chips.com (addy ke)
Date: Thu, 30 Oct 2014 14:54:06 +0800
Subject: [PATCH] mmc: dw_mmc: add a quirk for the defferent bit of sdio
 interrupt
In-Reply-To: <CAD=FV=VgCjhO5n5VPo_8QmMPBg1ZDMR8nvmVHS=Le8bxEFmzeA@mail.gmail.com>
References: <1414635679-12565-1-git-send-email-addy.ke@rock-chips.com>	<CAD=FV=Uo3gcnGFn=gpZhV1r+qyZxJ_tpAEiSsu06P=csHTScug@mail.gmail.com>
 <CAD=FV=VgCjhO5n5VPo_8QmMPBg1ZDMR8nvmVHS=Le8bxEFmzeA@mail.gmail.com>
Message-ID: <5451E08E.2050701@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Doug,

On 2014/10/30 12:49, Doug Anderson wrote:
> Addy,
> 
> On Wed, Oct 29, 2014 at 9:41 PM, Doug Anderson <dianders@chromium.org> wrote:
>> You can avoid a lot of "if" tests if you just add a new "sdio->id"
> 
> Whoops, I mean "slot->sdio_id"
> 

To use "slot->sdio_id", I think the subject must be changed.
So I will drop this patch ,and send new patch to use "slot->sdio_id" for this difference.

thank you!

> 
> 
