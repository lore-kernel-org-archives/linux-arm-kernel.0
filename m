From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 May 2016 19:25:28 -0300
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <20160523220514.GB19428@n2100.arm.linux.org.uk>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
 <20160523182807.GY19428@n2100.arm.linux.org.uk>
 <CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
 <CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
 <CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
 <20160523210738.GZ19428@n2100.arm.linux.org.uk>
 <CAOMZO5DjjgNk+uHyH7Avvfrt_TNPaZ+SUtHzON5fPU=25_gKOg@mail.gmail.com>
 <20160523220514.GB19428@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5D8-GF-0MDExM=2si1yNcqwO07pNWUkjRz0uuzkdYka_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 7:05 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> I don't think so, unless you specifically turn off CONFIG_SMP_ON_UP.
> It defaults to 'y', so imx_v6_v7_defconfig should result in this being
> 'y'.

Sorry, you are right: option 3 (CONFIG_SMP=y and CONFIG_SMP_ON_UP=y)
is the default one with imx_v6_v7_defconfig.
