From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Feb 2017 13:56:46 +0100
Subject: [PATCH 2/4] Documentation: devicetree: arm: Document Marvell
 IAP140
In-Reply-To: <20170219032000.4674-3-afaerber@suse.de>
References: <20170219032000.4674-1-afaerber@suse.de>
 <20170219032000.4674-3-afaerber@suse.de>
Message-ID: <20170220135646.2b0219c1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, 19 Feb 2017 04:19:58 +0100, Andreas F?rber wrote:

> + - compatible :  must contain "mrvl,iap140"

Even though there's indeed a good number of existing "mrvl," compatible
strings in the tree, the official vendor prefix according to
Documentation/devicetree/bindings/vendor-prefixes.txt is "marvell".
Probably you should use that instead for new bindings?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
