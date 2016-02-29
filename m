From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Feb 2016 11:23:25 -0300
Subject: Booting MX7Solo with 4.5-rc6
Message-ID: <CAOMZO5A6AO1n+fiwYBa=7VS3i1qk6zZ_ifym1yPt6+ApcTAuoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to boot linux-next 20160229 on a m7solo warp board and
this is what I get:

http://pastebin.com/TmQdqd2B

I can boot this board fine using NXP 3.14.52 kernel.

These clock warnings also happen on a mx7d sabresd board, but the boot
proceed fine.

Any ideas as to what needs to be done in order to boot a MX7S?

I have also tried to disable cpu1 in the imx7d.dtsi, but it did not help.

Thanks
