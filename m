From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 15 Sep 2014 16:06:49 +0300
Subject: [PATCH v3] spi: davinci: add support for adding delay between
 word's transmissions
In-Reply-To: <20140913160628.GF7960@sirena.org.uk>
References: <1410536892-22775-1-git-send-email-grygorii.strashko@ti.com>
 <20140913160628.GF7960@sirena.org.uk>
Message-ID: <5416E469.3020806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2014 07:06 PM, Mark Brown wrote:
> On Fri, Sep 12, 2014 at 06:48:12PM +0300, Grygorii Strashko wrote:
>> From: Murali Karicheri <m-karicheri2@ti.com>
>>
>> This patch adds ability to configure delay between transmission of
>> words over SPI bus if it's required by SPI slave devices.
> 
> This is fine but it doesn't appear to apply against current code.  Can
> you please check and resend?
> 

This one should be applied without conflicts on top of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
branch: for-next

since you've applied the patch:
"[PATCH] spi: davinci: request cs_gpio's from probe"
http://www.spinics.net/lists/linux-spi/msg01811.html

I have to mention about this dependency, sorry for that.

Regards,
-grygorii
