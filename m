From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Aug 2012 12:41:15 +0100
Subject: [PATCH 1/1 v2] i2c: Add default configuration into the Nomadik
 I2C driver.
In-Reply-To: <CACRpkdZjbyQbht+UpXrrVGhAzGYPjb=HRZhJ+TvsEXhGeviJLA@mail.gmail.com>
References: <1344266253-14050-1-git-send-email-lee.jones@linaro.org>
 <20120806153503.GH10524@gmail.com>
 <CACRpkdZjbyQbht+UpXrrVGhAzGYPjb=HRZhJ+TvsEXhGeviJLA@mail.gmail.com>
Message-ID: <20120807114113.GA5684@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch b/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch
> > new file mode 120000
> > index 0000000..427334b
> > --- /dev/null
> > +++ b/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch
> > @@ -0,0 +1 @@
> 
> NACK, what is this stuff? It's even out-of-tree code.

Whoa, no idea! Good spot though, I missed this completely.

> Please be careful with git add -A, I prefer to use git add <pathspec>
> I suspect that may be why this happened...

I don't use `git add -A`, ever. If I'm adding files, I usually use 
`git commit -s -- <pathspec>`, or `git commit -a` if I'm sure I require
all the necessary changes. I guess I could have accidentally collected 
it using `git add -i` whist fixing it up, or a similar misdemeanor.

> Please fix it up and send a v3.

Of course.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
