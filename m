From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 1 May 2010 17:45:50 -0700
Subject: [PATCH 2/3] DMAENGINE: DMA40 logical channel fixes
In-Reply-To: <1271481151-9589-1-git-send-email-linus.walleij@stericsson.com>
References: <1271481151-9589-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <z2re9c3a7c21005011745te4a8de7fn16d26737c9fcd1af@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 10:12 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This fixes some small bugs relating to the handling of logical
> channels in the DMA40 driver:
>
> - Fix a bug when asking for paused status of a logical channel
> ?would fail (bug found by Jonas Aaberg)
> - Handle DMA channel request for logical channel 0 (bug found by
> ?Marcin Mielczarczyk)
>
> Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---

I appreciate the environmentally friendly aspect of combining two
fixes into one patch :-).  But if there are two fixes with two
changelogs can we have two patches?  Future developers looking to do
reverts and bisects will appreciate the upfront effort.

--
Dan
