From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 21 Aug 2017 22:10:51 +0530
Subject: [PATCH] ste_dma40: make stedma40_chan_cfg const
In-Reply-To: <20170821162730.GQ3053@localhost>
References: <1502630584-6844-1-git-send-email-bhumirks@gmail.com>
 <20170821162730.GQ3053@localhost>
Message-ID: <CAOH+1jGam4rPgrYCDADg_mgk+ZPoowd6xbLaw_o+=ct41AuNZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 9:57 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Sun, Aug 13, 2017 at 06:53:04PM +0530, Bhumika Goyal wrote:
>> Make these const as they are only used during a copy operation.
>> Done using Coccinelle.
>
> Pls make sure you use the right subsystem tags, hint, you cna check git log
> on that subsystem/file to find the right ones
>

Thanks for the note. I will be more careful next time.

Thanks,
Bhumika

> Applied after fixing the tags, thanks
>
> --
> ~Vinod
