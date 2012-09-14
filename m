From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 14 Sep 2012 11:39:45 +0200
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed
 via Device Tree
In-Reply-To: <20120914090228.GH3374@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
 <20120914090228.GH3374@gmail.com>
Message-ID: <20120914093945.GB2630@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ah, sorry. That's my fault for rushing though my ridiculously bloated post-
> vacation inbox.

:)

> > all the infos I got. Some more context would have been helpful. Is there
> > a branch somewhere with all the things collected?
> 
> There will be. I'm currently just Ack collecting. 
> 
> In fact wait ...
> 
> <3 mins pass>
> 
> Now there is:
>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git preview-for-next

OK from having a glimpse, I'd prefer to squash (or have squashed)

	i2c: nomadik: Add Device Tree support to the Nomadik I2C driver
	Documentation: Device Tree binding information for i2c-nomadik driver
		(Documentation should go along with the code)
	i2c-nomadik: Register sub-devices when passed via Device Tree

into one patch and take that via the I2C tree. This will allow me to
resolve the merge conflict in my tree on my own. I don't see a strong
reason to have those go via arm-soc (like prevented build-failures or
easier merges), if I missed such a reason, please let me know.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120914/4f74d98d/attachment.sig>
