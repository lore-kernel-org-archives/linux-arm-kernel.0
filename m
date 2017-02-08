From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 8 Feb 2017 19:08:26 +0100 (CET)
Subject: [PATCH v2 2/8] mmc: bcm2835: Add new driver for the sdhost
 controller.
In-Reply-To: <1486454575.24589.29.camel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
 <1486123913-31705-3-git-send-email-kraxel@redhat.com>
 <1708749883.208474.1486413240581@email.1und1.de>
 <1486454575.24589.29.camel@redhat.com>
Message-ID: <2084617651.273763.1486577306244@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Gerd Hoffmann <kraxel@redhat.com> hat am 7. Februar 2017 um 09:02 geschrieben:
> ...
> > 
> > I'll send it after my tests. In the following review i will mention only the issues which aren't fixed in my patch series.
> 
> I'll pick up the patches and look at the remaining issues, new version
> later this week (i hope).

No need to hurry. The merge window opens soon.

Do you take care of the missing downstream patch ( bcm2835-sdhost: Only claim one DMA channel ) which affects most of your patch series?

> 
> thanks,
>   Gerd
>
