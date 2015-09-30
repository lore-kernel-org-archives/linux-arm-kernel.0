From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:59:17 +0200
Subject: [PATCH 15/16] usb: gadget: atmel: access the PMC using regmap
In-Reply-To: <20150930163102.GM32625@saruman.tx.rr.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1443629469-15086-16-git-send-email-alexandre.belloni@free-electrons.com>
 <20150930163102.GM32625@saruman.tx.rr.com>
Message-ID: <20150930165917.GE3639@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/09/2015 at 11:31:02 -0500, Felipe Balbi wrote :
> On Wed, Sep 30, 2015 at 06:11:08PM +0200, Alexandre Belloni wrote:
> > Use regmap to access the PMC to avoid using at91_pmc_read and
> > at91_pmc_write.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> can I take this through my tree or does it have any dependences with the rest of
> the series ?
> 

This actually depend on the DT change. I'd say that we can safely assume
that the DT change will land in the next kernel version so you could
take that patch in your tree.

Nicolas, what is your opinion?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
