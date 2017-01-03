From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 3 Jan 2017 17:51:05 +0100
Subject: [PATCH RESEND] dmaengine: stm32-dma: Rework starting transfer
 management
In-Reply-To: <20170103035703.GE3573@localhost>
References: <1483349607-16870-1-git-send-email-cedric.madianga@gmail.com>
 <20170103035703.GE3573@localhost>
Message-ID: <CAOAejn2=xksxXmfzVRJV-5hAkbNyPX88vWUyPkGdh+ynoTkCdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> ah sorry, i missed to push topic/stm32-dma. can you rebase onnthis and
> resend again. Btw this fails as as well..
I have tried again and I don't have any issue.
Please see below my way of working and let me know if there is
something I don't understand:

slave-dma git://git.infradead.org/users/vkoul/slave-dma.git
$ git fetch slave-dma
$ git checkout -b dma-fixes slave-dma/topic/dma-fixes
$ git checkout -b dma-stm32 slave-dma/topic/stm32-dma
$ git rebase dma-fixes
First, rewinding head to replay your work on top of it...
Applying: dmaengine: stm32-dma: Fix typo in Kconfig
Applying: dt-bindings: stm32-dma: Fix typo regarding DMA client binding
Applying: dmaengine: stm32-dma: Rework starting transfer management
Applying: dmaengine: stm32-dma: Fix residue computation issue in cyclic mode
Applying: dmaengine: stm32-dma: Add synchronization support
Applying: dmaengine: stm32-dma: Add max_burst support

Best regards,

Cedric
