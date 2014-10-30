From: dianders@chromium.org (Doug Anderson)
Date: Wed, 29 Oct 2014 21:49:48 -0700
Subject: [PATCH] mmc: dw_mmc: add a quirk for the defferent bit of sdio
 interrupt
In-Reply-To: <CAD=FV=Uo3gcnGFn=gpZhV1r+qyZxJ_tpAEiSsu06P=csHTScug@mail.gmail.com>
References: <1414635679-12565-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=Uo3gcnGFn=gpZhV1r+qyZxJ_tpAEiSsu06P=csHTScug@mail.gmail.com>
Message-ID: <CAD=FV=VgCjhO5n5VPo_8QmMPBg1ZDMR8nvmVHS=Le8bxEFmzeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Wed, Oct 29, 2014 at 9:41 PM, Doug Anderson <dianders@chromium.org> wrote:
> You can avoid a lot of "if" tests if you just add a new "sdio->id"

Whoops, I mean "slot->sdio_id"
