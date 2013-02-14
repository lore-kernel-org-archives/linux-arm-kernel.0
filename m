From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 14 Feb 2013 15:22:22 +0200
Subject: [PATCH v4] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87obfn9gj5.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> 4th round of patches.
>
> Peter, I would be glad if you could test them before your holiday. I rebased
> your last round of Chipidea OTG patches onto this series which you can pull
> here:
>
> git://git.pengutronix.de/git/imx/linux-2.6.git tags/usb-chipidea-otg-for-next
>
> I couldn't really test the otg patches since my current hardware does not have
> the ID pin connected, but I can verify that my usecase still works with your
> patches applied.
>
> Alex, should the patches work for you and are fine otherwise, could you apply
> them for v3.9?

Looks good in general. I just realised the comment I made on 5/9 is not
entirely valid, but the dr_mode setting needs one extra option as was
discussed. Also, all the phy/otg patches (1/9, 2/9, 3/9, 8/9) need
Felipe's ack, then I can apply the series.

Regards,
--
Alex
