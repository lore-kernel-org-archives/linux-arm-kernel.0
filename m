From: arokux@gmail.com (Arokux X)
Date: Tue, 15 Oct 2013 23:12:00 +0200
Subject: [linux-sunxi] [PATCH v2 1/4] reset: Add Allwinner A31 Reset
 Controller Driver
In-Reply-To: <1381778609-4191-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1381778609-4191-1-git-send-email-maxime.ripard@free-electrons.com>
 <1381778609-4191-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAPNxgga7N-RYXDEDoK_J3MhA+YvGf2H9GuHqSURQJV+hDPSAPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 9:23 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The Allwinner A31 has an IP maintaining a few other IPs in the SoC in
> reset by default. Among these IPs are the High Speed Timers, hence why
> we can't use the regular driver construct, and need to call the
> registering function directly during machine initialisation.

Maybe it is better to have a more generic commit message here, since
this driver will be used for all the sunxi.
