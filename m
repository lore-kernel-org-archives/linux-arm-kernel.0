From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue, 31 Jan 2017 09:10:34 +0100
Subject: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
In-Reply-To: <2012885435.15821.1485812279271@email.1und1.de>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-2-git-send-email-kraxel@redhat.com>
 <2012885435.15821.1485812279271@email.1und1.de>
Message-ID: <1485850234.23903.18.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mo, 2017-01-30 at 22:37 +0100, Stefan Wahren wrote:
> > Gerd Hoffmann <kraxel@redhat.com> hat am 27. Januar 2017 um 12:36 geschrieben:
> > 
> > 
> > From: Eric Anholt <eric@anholt.net>
> > 
> > This is the other SD controller on the platform, which can be swapped
> > to the role of SD card host using pin muxing.
> 
> AFAIK the SDHOST controller isn't able to handle SDIO. Maybe we should
> mention this in the binding document.

Hmm, I think the driver commit message and the Kconfig help text are
better places for that.

cheers,
  Gerd
