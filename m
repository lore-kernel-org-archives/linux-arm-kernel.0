From: sakoman@gmail.com (Steve Sakoman)
Date: Fri, 15 Apr 2011 06:17:51 -0700
Subject: [PATCH] Fixed gpio polarity of gpio USB-phy reset.
In-Reply-To: <20110414103254.GC14319@legolas.emea.dhcp.ti.com>
References: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
	<20110414103254.GC14319@legolas.emea.dhcp.ti.com>
Message-ID: <BANLkTinNpMcuk0dpobM1Nu4zeU3yo8QQvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 3:32 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Apr 14, 2011 at 09:31:43AM +0200, Juergen Kilb wrote:
>> With commit 19403165 a main part of ehci-omap.c moved to
>> drivers/mfd/omap-usb-host.c created by commit 17cdd29d.
>> Due to this reorganisation the polarity used to reset the
>> external USB phy changed and USB host doesn't recognize
>> any devices.
>>
>> Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>
>
> Judging by how ehci-omap.c was before moving the code:
>
> Acked-by: Felipe Balbi <balbi@ti.com>

This fixes the issue on Overo:

Tested-by: Steve Sakoman <steve@sakoman.com>

Steve
