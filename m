From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 May 2016 23:10:54 -0300
Subject: mx6ul cannot reboot
In-Reply-To: <CAOMZO5DLz7vBARB+uweDG+tw0UM3EMDb9+_XcLaaBv0GN+im7g@mail.gmail.com>
References: <CAOMZO5DLz7vBARB+uweDG+tw0UM3EMDb9+_XcLaaBv0GN+im7g@mail.gmail.com>
Message-ID: <CAOMZO5CF7g=GOXL_BMRQTZ6UPk+15z3hkxoM3j+KW033Dtp7wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 6:12 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> After issuing a 'reboot' command on mx6ul-evk running 4.6-rc I get the
> following problem:

....

> I have only seen this on mx6ul.

The cpufreq-imx6q driver does not support mx6ul yet, so in order to
fix this issue I had to revert 7f7308198f98700be ("ARM: imx: add
cpufreq device for imx6ul"). Just sent a patch with the revert.
