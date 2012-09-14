From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 11:15:44 +0100
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed via
 Device Tree
In-Reply-To: <20120914093945.GB2630@pengutronix.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
 <20120914090228.GH3374@gmail.com>
 <20120914093945.GB2630@pengutronix.de>
Message-ID: <20120914101542.GT3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Now there is:
> >   git://git.linaro.org/people/ljones/linux-3.0-ux500.git preview-for-next
> 
> OK from having a glimpse, I'd prefer to squash (or have squashed)
> 
> 	i2c: nomadik: Add Device Tree support to the Nomadik I2C driver
> 	i2c-nomadik: Register sub-devices when passed via Device Tree

Sure, no problem

> 	Documentation: Device Tree binding information for i2c-nomadik driver
> 		(Documentation should go along with the code)

I'm still not too sure about how this benefits anyone. You can ensure
the documentation is placed in an adjacent patch, so it's just as easy
to make reference to.

> into one patch and take that via the I2C tree. This will allow me to
> resolve the merge conflict in my tree on my own. I don't see a strong
> reason to have those go via arm-soc (like prevented build-failures or
> easier merges), if I missed such a reason, please let me know.

I don't have any good reasons for you not to take the patch(es) though
your tree. Please go ahead.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
