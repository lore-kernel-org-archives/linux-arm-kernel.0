From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 16 Oct 2013 10:02:38 +0200
Subject: [linux-sunxi] [PATCH v2 1/4] reset: Add Allwinner A31 Reset
 Controller Driver
In-Reply-To: <CAPNxgga7N-RYXDEDoK_J3MhA+YvGf2H9GuHqSURQJV+hDPSAPw@mail.gmail.com>
References: <1381778609-4191-1-git-send-email-maxime.ripard@free-electrons.com>
 <1381778609-4191-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAPNxgga7N-RYXDEDoK_J3MhA+YvGf2H9GuHqSURQJV+hDPSAPw@mail.gmail.com>
Message-ID: <20131016080238.GC3041@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 11:12:00PM +0200, Arokux X wrote:
> On Mon, Oct 14, 2013 at 9:23 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The Allwinner A31 has an IP maintaining a few other IPs in the SoC in
> > reset by default. Among these IPs are the High Speed Timers, hence why
> > we can't use the regular driver construct, and need to call the
> > registering function directly during machine initialisation.
> 
> Maybe it is better to have a more generic commit message here, since
> this driver will be used for all the sunxi.

Right. I'll change it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131016/d8f86f7e/attachment.sig>
