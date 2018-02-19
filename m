From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 08:49:05 -0600
Subject: [PATCH v2 1/1] clk: npcm750: update text with fixed clocks
In-Reply-To: <CAFd5g44gBJp0-mYEWGdyiA67BCi2pZWAG2bYPS-WdJEwH1oA5A@mail.gmail.com>
References: <1518701959-22899-1-git-send-email-tali.perry1@gmail.com>
 <1518701959-22899-2-git-send-email-tali.perry1@gmail.com>
 <CAFd5g44gBJp0-mYEWGdyiA67BCi2pZWAG2bYPS-WdJEwH1oA5A@mail.gmail.com>
Message-ID: <20180219144905.bfrycjnas7dcuo34@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 02:38:12PM -0800, Brendan Higgins wrote:
> On Thu, Feb 15, 2018 at 5:39 AM, Tali Perry <tali.perry1@gmail.com> wrote:
> >
> > Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> >
>  <snip>
> 
> I think this should probably be rolled into [PATCH v2 1/1] npcm750: add fixed
> clocks (moved from drivers/clk/clk-npcm7xx.c):
> https://www.spinics.net/lists/arm-kernel/msg634678.html

No, binding docs, dts files and driver code should all be separate 
patches.

Rob
