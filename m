From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jun 2018 11:10:11 +0200
Subject: [Dev] [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <616e99d3-b43e-58ca-aa82-eaf41f618682@xilinx.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAK8P3a2KqoX-squhGc8TBuJ==8xxELsuy-H+c1+C7Fu7Z4OjDA@mail.gmail.com>
 <CAKv+Gu-gAkfRsEUOc=iyxi6Twvg9cbvWNqNHRS2HzUDZg8xUhg@mail.gmail.com>
 <CAMuUZTG0q4f2T=+HjEijUCLb7KNXok9RJHOXOKNs2iap5p7m5Q@mail.gmail.com>
 <CAKv+Gu_Dq1uY0wHRyREmCmQdSRSJbNheF1ZsrNhibKOZowvf+g@mail.gmail.com>
 <CAMuUZTHOuzQm3y-yF6cad9y1UgsK+6R2w7vSzz7MkkYCdYd3hA@mail.gmail.com>
 <CAKv+Gu80zzaahJhoMScvZ9dS31QobMa0+JFjaOo-GxD+4XsuWQ@mail.gmail.com>
 <CAMuUZTH8wXhoBSKwsCFBRBzAvvBBTUTnkmwKEpq=56=URo7kjQ@mail.gmail.com>
 <616e99d3-b43e-58ca-aa82-eaf41f618682@xilinx.com>
Message-ID: <CACRpkdYY=o==9D9-vuqkL2xgWzJf+gQtfm0WxyK08Qps=t05sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 3:09 PM Michal Simek <michal.simek@xilinx.com> wrote:

> I have told to Linus what Xilinx is using for FMC connector present on
> the most of xilinx development boards.
> These on board FMC eeproms contain information in FRU format.
> Also there incomplete support fmc support in the kernel in drivers/fmc
> which was added by Alessandro Rubini in 2013.
>
> At least these eeprom could reuse FRU data format.

The FRU is a very tasteful design IMO and since it is a discoverable
(plug and play!) bus I think we should have a clean FRU bus
driver along Alessandro's suggestion to support them and spawn
devices much like I do, as long as there is interest and
some person who spends time writing the bus driver for it.

Yours,
Linus Walleij
