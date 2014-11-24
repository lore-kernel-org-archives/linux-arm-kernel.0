From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 24 Nov 2014 23:27:13 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <CAOMZO5BtUaYbQUhidgyPBFdARsFY=uYySYqXXmFEfPL8qTBbfQ@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201409051552.05447@pali>
 <CAOMZO5BtUaYbQUhidgyPBFdARsFY=uYySYqXXmFEfPL8qTBbfQ@mail.gmail.com>
Message-ID: <201411242327.13398@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 15:58:34 Fabio Estevam wrote:
> On Fri, Sep 5, 2014 at 10:52 AM, Pali Roh?r 
<pali.rohar@gmail.com> wrote:
> > So what is your suggestion for identifing board (name/type)
> > which will work with any kernel (and will not be broken
> > again by kernel later)?
> 
> $ cat /sys/bus/soc/devices/soc0/machine
> Freescale i.MX6 Quad SABRE Smart Device Board

This output is on Nokia N900 useless:

$ cat /sys/bus/soc/devices/soc0/machine
OMAP3430/3530

It does not specify that this is Nokia N900 (RX-51) device but 
only some generic omap board.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/823526be/attachment.sig>
