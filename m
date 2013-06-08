From: robherring2@gmail.com (Rob Herring)
Date: Sat, 8 Jun 2013 13:54:27 -0500
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <20130607112101.2cedbc5f@skate>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
 <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
 <20130607112101.2cedbc5f@skate>
Message-ID: <CAL_Jsq+Ysc0xdLSv_QYwngvcYv80RrMxWbf_pZmJgBuDaSPWxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 4:21 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Nicolas Pitre,
>
> On Thu, 6 Jun 2013 13:27:38 -0400 (EDT), Nicolas Pitre wrote:
>
> Marvell will release a DT-capable U-Boot in some time, that will
> properly adjust the MAC addresses in the DTB before handing it over to
> the kernel. We are currently working with Marvell to define which
> actions the bootloader should do on the DTB before handing it over to
> the kernel. I believe this is a sufficient proof that there is no
> laziness from Marvell's side and that things are progressing towards a
> full DT based boot protocol.

Hopefully the lesson on custom ATAGs has been learned and we don't
repeat it with something custom and undocumented in DT. I don't want
to hear "we're already using this binding in our bootloader and can't
change it". This example doesn't apply to MAC addresses since there
already is a defined way, but I'm sure there are other examples. That
is what I've gotten from the OLPC folks before.

Rob
