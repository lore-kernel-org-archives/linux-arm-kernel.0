From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 17 Jun 2012 22:27:33 -0600 (MDT)
Subject: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1206172225450.10859@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Jun 2012, Rajendra Nayak wrote:

> OMAP3 has suspend broken in mainline, so I tested it on an
> older kernel (3.4-rc4 using my RFC series)
> Idle and OFF mode however seem to be broken for a long time,
> I wasn;t able to get it working even on 3.4 major.
> See my logs '3630 Beagle-Xm broken idle/off on 3.4' if
> I am doing anything wrong. I have CPUidle enabled in the
> kernel config.

http://www.spinics.net/lists/arm-kernel/msg173688.html


- Paul
