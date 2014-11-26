From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 26 Nov 2014 18:56:54 +0100
Subject: [PATCH v2 0/2] Pinctrl fixes for rockchip
In-Reply-To: <1416437493-25588-1-git-send-email-dianders@chromium.org>
References: <1416437493-25588-1-git-send-email-dianders@chromium.org>
Message-ID: <1796168.f97MNRYGcl@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Am Mittwoch, 19. November 2014, 14:51:31 schrieb Doug Anderson:
> These two patches fix some pinctrl issues on rockchip.  The first
> fixes a real issue where interrupts were being left on in
> suspend/resume and waking the system up when they shouldn't.  The
> second fixes purely theoretical problems but seems clean.
> 
> I've tested these patches more extensively on a non-mainline tree but
> have done basic compile and boot testing on mainline.  I don't have
> suspend/resume working so well on mainline yet, so I haven't tested
> fully there.

As indicated by my review-tag in the patches, these look good to me.
Do you want to take them normally [they should simply go on top of the other 
patches] or do you prefer another pull request - which feels strange for only 
two patches :-) .


Thanks
Heiko
