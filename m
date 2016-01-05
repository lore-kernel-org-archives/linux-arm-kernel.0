From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jan 2016 22:26:33 +0100
Subject: Including Raspberry Pi -next trees in linux-next
In-Reply-To: <568C2619.20705@wwwdotorg.org>
References: <87fuyozzax.fsf@eliezer.anholt.net>
 <87d1tfrdu0.fsf@eliezer.anholt.net> <568C2619.20705@wwwdotorg.org>
Message-ID: <3082544.lZk2r7IkWv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 13:22:49 Stephen Warren wrote:
> >>>
> >>> branches:
> >>> drm-vc4-next
> >>> bcm2835-dt-next
> >>> bcm2835-soc-next
> >>> bcm2835-drivers-next
> >>> bcm2385-defconfig-next
> >>> (bcm2835-maintainers-next is a placeholder since we have nothing for it
> >>> this round)
> 
> Typically maintainers merge everything together into a single "for-next" 
> to maintain a reasonable set of branches. I guess it doesn't affect me 
> so my opinion isn't too relevant though:-)

In my experience the common for-next branch works best because
you can change the set of branches that get merged into it as
needed. If there are 6 branches today, it's quite likely that there
will be another one in the future and if only one branch gets
merged into for-next, you don't need to worry about updating the list.

	Arnd
