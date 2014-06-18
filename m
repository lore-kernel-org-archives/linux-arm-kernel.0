From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Jun 2014 18:53:00 -0300
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <201406182220.22818@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201406182122.29623@pali>
 <20140618200053.GK32514@n2100.arm.linux.org.uk>
 <201406182220.22818@pali>
Message-ID: <CAOMZO5DZSxeTC9fKYXk6XBAG-03qW+TM_8HS_3M8Mkbd-iEdzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 5:20 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
>
> So how to read Revision and Serial number in DT based kernel?

$ cat /sys/bus/soc/devices/soc0/soc_id
i.MX6SX

$ cat /sys/bus/soc/devices/soc0/revision
1.0

$ cat /sys/bus/soc/devices/soc0/machine
Freescale i.MX6 SoloX SDB Board
