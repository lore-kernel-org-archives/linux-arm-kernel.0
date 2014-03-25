From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Mar 2014 22:24:03 -0300
Subject: USB OTG on mx51
In-Reply-To: <CAOMZO5Cpap7atPOSHSKdUgcsnZrmG=Q5REhyn6UOq=M-aGNX2w@mail.gmail.com>
References: <CAOMZO5Cpap7atPOSHSKdUgcsnZrmG=Q5REhyn6UOq=M-aGNX2w@mail.gmail.com>
Message-ID: <CAOMZO5Bnpa2ui5QT5GNxM8asg0n+s0JFY1wubeeDZJxfVzm0eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 8:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Denis/Eric,
>
> Have you managed to get USB OTG functional on the eukrea-cpuimx51 board?
>
> USB host1 works fine on mx51evk with this patch:
> http://pastebin.com/Z2FYSW8m
>
> ,but g_ether is not working on the USB OTG port yet. It is like the PC
> does not notice that  the USB cable has been inserted.
>
> Do we need to change usbmisc_imx.c ?

Yes, this is needed indeed. I got it working and will submit the patches soon.

Regards,

Fabio Estevam
