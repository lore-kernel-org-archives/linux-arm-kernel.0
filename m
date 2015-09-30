From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Sep 2015 18:39:03 +0200
Subject: [PATCH 15/16] usb: gadget: atmel: access the PMC using regmap
In-Reply-To: <20150930163102.GM32625@saruman.tx.rr.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1443629469-15086-16-git-send-email-alexandre.belloni@free-electrons.com>
 <20150930163102.GM32625@saruman.tx.rr.com>
Message-ID: <560C1027.9060100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/09/2015 18:31, Felipe Balbi a ?crit :
> On Wed, Sep 30, 2015 at 06:11:08PM +0200, Alexandre Belloni wrote:
>> Use regmap to access the PMC to avoid using at91_pmc_read and
>> at91_pmc_write.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> can I take this through my tree or does it have any dependences with the rest of
> the series ?

Hi Felipe,

Well, I have the feeling that these changes would require the regmap to
be in place before using it. So yes, it has a strong dependency with the
rest of the series (and DT modifications like the 06/16 patch actually).

So, I think that Alexandre would agree with me that we should take the
whole series with us through the arm-soc tree. An alternative would be
to delay the inclusion of the USB part a little bit...

Thanks for the heads-up Felipe, Bye,
-- 
Nicolas Ferre
