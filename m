From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 10:02:49 -0500
Subject: [PATCH v6 00/18] ahci: library-ise ahci_platform, add sunxi
 driver and cleanup imx driver
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140219150249.GG10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 19, 2014 at 01:01:42PM +0100, Hans de Goede wrote:
> Here is v6 of my patchset for adding ahci-sunxi support. This has been
> tested with Allwinner A10, Allwinner A20 and Freeware imx6x SoCs, including
> suspend / resume. Note that since my last revision the ahci_imx driver has
> also grown imx53 sata support, it would be good if some-one could test that
> with this series.

Stopping review here.  I really like where it's headed in general and
most review points, except for lack of devres usage, are rather
cosmetic.  I'm not completely decided yet whether we can defer devres
until later or should go for it in the first round.

Thanks.

-- 
tejun
