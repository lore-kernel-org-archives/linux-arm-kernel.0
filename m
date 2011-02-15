From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Feb 2011 13:58:00 +0100
Subject: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
In-Reply-To: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
Message-ID: <AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/11 Eduardo Valentin <eduardo.valentin@nokia.com>:

> Here is the version 5 of the change to export OMAP data to userspace
> (name, revision, id code, production id and die id).
>
> Basically, this version is still attempting to create a new file under /proc.
> It is the /proc/socinfo, which should be used to export bits which are SoC specific
> (not CPU related, nor machine related).
>
> So, differences between previous version are:
> - merged patch 02/04 with 03/04 to avoid compilation breakages.
> - simplified the seq_file usage by using the single_open and single_release functions
> - exported a function to register a seq_operation .show callback
> - adapted the changes accordingly
>
> As usual, comments are welcome.

Eduardo, what has happened to this patchset?

Now we need something similar for arch/arm/mach-ux500 and I was sort of
hoping that this infrastructure would be in place already... wrong I was.

Do you want help in picking it up and try to polish it up?

Yours,
Linus Walleij
