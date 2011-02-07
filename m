From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Feb 2011 09:45:01 -0800
Subject: [PATCH] [ARM] tegra: Add i2c support
References: <1283466103-20889-1-git-send-email-ccross@android.com>
	<AANLkTimYURYGix-0Xk3wdf1A-XEAJbBXR_JDn1BFw_uq@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F5FC90@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Sent: Monday, January 31, 2011 3:49 PM:
> 
> Colin Cross wrote at Tuesday, December 21, 2010 5:12 PM:
> >
> > On Thu, Sep 2, 2010 at 3:21 PM, Colin Cross <ccross@android.com> wrote:
> > > Signed-off-by: Colin Cross <ccross@android.com>
> > > ---
> > > ?drivers/i2c/busses/Kconfig ? ? | ? ?7 +
> > > ?drivers/i2c/busses/Makefile ? ?| ? ?1 +
> > > ?drivers/i2c/busses/i2c-tegra.c | ?665 ++++++++++++++++++++++++++++++++++++++++
> > > ?include/linux/i2c-tegra.h ? ? ?| ? 25 ++
> > > ?4 files changed, 698 insertions(+), 0 deletions(-)
> > > ?create mode 100644 drivers/i2c/busses/i2c-tegra.c
> > > ?create mode 100644 include/linux/i2c-tegra.h
> > >
> > Ben, this didn't make it into 2.6.37?  Can it go into next-i2c?
> 
> I didn't see any response to this request, at least not in the linux-tegra
> archives.

Ben, did Colin's latest patch look good; could it be applied?

Colin, perhaps you could repost the patch in case it's fallen out of Ben's
inbox.

As background, I'd really like this patch to show up in 2.6.39; the ASoC
driver I've upstreamed for Tegra Harmony (and which will be in 2.6.39) relies
on this I2C driver to provide communication with the audio codec. Hence, the
ASoC driver is useless without the I2C driver also merged.

Thanks.

-- 
nvpublic
