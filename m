From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Mar 2012 09:41:04 -0800
Subject: [PATCH] pinctrl: resurrect verbose pinmux-pins
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE861978@HQMAIL01.nvidia.com>
References: <1330705873-10798-1-git-send-email-linus.walleij@stericsson.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861978@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861991@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Friday, March 02, 2012 10:22 AM:
> Linus Walleij wrote at riday, March 02, 2012 9:31 AM:
> > From: Linus Walleij <linus.walleij@linaro.org>
> >
> > This reintroduces the verbosity in the pinmux-pins file, now this
> > file will list all pins, their names, owning device (and if it's
> > a hog) and also in applicable cases the function and group making
> > use of that pin right now.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It'd be nice if we could defer this fix until after all the API rework,
> because it'll cause all kinds of conflicts otherwise.

Oh, I see this patch is in your for-next branch already before I had a chance
to comment on it. I guess I'll have write a patch to convert the removed struct
type to char*s and rebase on top of it:-(

--
nvpublic
