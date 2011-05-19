From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 19:38:22 +0200
Subject: [PATCH] drivers: create a pinmux subsystem v2
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A47BF9@HQMAIL01.nvidia.com>
References: <1305070783-23193-1-git-send-email-linus.walleij@linaro.org>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A478E6@HQMAIL01.nvidia.com>
	<BANLkTimMHjUFN8NqAxoF5h_eXgmJP+znSg@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A47BF9@HQMAIL01.nvidia.com>
Message-ID: <BANLkTikeY5QVpEa8uXckcFGvUf7Lg1PviA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/19 Stephen Warren <swarren@nvidia.com>:

> Still, if I was writing the patches, and I agreed with the above change,
> I think I'd want to put it into the first patchset (or at least before
> other people started implementing their pinmux drivers on top of the code)
> since it'd avoid everyone else (or me) having to refactor all their
> drivers almost immediately after writing them, plus it looks like a very
> simple change to the current pinmux patchset.

You're right and Sascha said the same thing, so I will includ it
in v3. I expect an Acked-by: in return ;-)

Yours,
Linus Walleij
