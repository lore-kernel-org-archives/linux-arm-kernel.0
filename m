From: balbi@ti.com (Felipe Balbi)
Date: Wed, 30 Sep 2015 11:31:02 -0500
Subject: [PATCH 15/16] usb: gadget: atmel: access the PMC using regmap
In-Reply-To: <1443629469-15086-16-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1443629469-15086-16-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150930163102.GM32625@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 06:11:08PM +0200, Alexandre Belloni wrote:
> Use regmap to access the PMC to avoid using at91_pmc_read and
> at91_pmc_write.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

can I take this through my tree or does it have any dependences with the rest of
the series ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/49d81d27/attachment.sig>
