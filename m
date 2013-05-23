From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 May 2013 16:30:15 +0100
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <20130523151816.GB6406@sirena.org.uk>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
 <20130522155347.GJ1627@sirena.org.uk>
 <20130522165353.GB18714@gmail.com>
 <20130522174516.GT1627@sirena.org.uk>
 <20130523070905.GD18714@gmail.com>
 <20130523142419.GG2412@sirena.org.uk>
 <20130523144453.GL22683@gmail.com>
 <20130523151816.GB6406@sirena.org.uk>
Message-ID: <20130523153015.GN22683@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Mark Brown wrote:

> On Thu, May 23, 2013 at 03:44:53PM +0100, Lee Jones wrote:
> 
> > Well, whatever happens I'm going to be able to refactor the driver in
> > the -rc:s, so we still need this fix, or the world will end.
> 
> Why is it so invasive to have the driver cope with absent constraints?

It probably isn't. Are you asking me to code that up for the -rc:s?

I would be happier if I could stick it onto my TODO and address it
at another time for inclusion into -next, as I have a list of priority
items to attend to in the immediate future.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
