From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 15 Sep 2015 13:49:11 +0200
Subject: [PATCH] spi: mediatek: fix wrong error return value on probe
In-Reply-To: <20150914183925.GG12027@sirena.org.uk>
References: <1441320656-8666-1-git-send-email-javier@osg.samsung.com>
 <20150914183925.GG12027@sirena.org.uk>
Message-ID: <55F805B7.7020706@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 09/14/2015 08:39 PM, Mark Brown wrote:
> On Fri, Sep 04, 2015 at 12:50:56AM +0200, Javier Martinez Canillas wrote:
>> Commit adcbcfea15d62 ("spi: mediatek: fix spi clock usage error")
>> added a new sel_clk but introduced bugs in the error paths since
>> the wrong struct clk pointers are passed to PTR_ERR().
> 
> This doesn't apply against current code, please check and resend.
> 

Which branch should I use as a baseline then? The patch applies cleanly
on both today's linux-next (next-20150915) and your for-linus branch:

https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=for-linus

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
