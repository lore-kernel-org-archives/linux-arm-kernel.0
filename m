From: marex@denx.de (Marek Vasut)
Date: Tue, 15 Oct 2013 18:34:32 +0200
Subject: [PATCH 0/6] PCI: imx6: Random fixes
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
Message-ID: <201310151834.33118.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> Set of random fixes for the PCIe driver for i.MX6 . With these fixes, my
> setup with MX6Q -> PCIe bridge -> i210 ethernet adapter works as expected.
> 
> NOTE: I'm sure this will start some discussion. There are quite a few
> patches that are more of a hacks. Shawn, I didn't ignore your remark about
> the clock patches, I will test it ASAP, I just want to have these fixes in
> the public so others can comment/test.

0002 and 0003 are NOT needed on my setup, Shawn. You were right, so please 
ignore these two.

Best regards,
Marek Vasut
