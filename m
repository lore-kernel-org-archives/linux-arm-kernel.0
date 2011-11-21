From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 21 Nov 2011 08:56:46 -0800
Subject: [PATCH v1] dts: tegra-ventana: use proper root instead of /dev/ram
In-Reply-To: <20111121004930.GA17338@quad.lixom.net>
References: <1321338087-3662-1-git-send-email-vwadekar@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740805E1B@HQMAIL01.nvidia.com>
 <20111121004930.GA17338@quad.lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C0B8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Sunday, November 20, 2011 5:50 PM:
> On Tue, Nov 15, 2011 at 11:16:51AM -0800, Stephen Warren wrote:
> > Varun Wadekar wrote at Monday, November 14, 2011 11:21 PM:
> > > From: Pritesh Raithatha <praithatha@nvidia.com>
> > >
> > > The root file system on ventana resides on /dev/mmcblk0p1.
...
> Actually, removing the default root path is probably a better idea, since it
> will vary from installation to installation and doesn't make sense to hard
> code.
...
> So, I would rather see a patch removing the root= argument alltogether.

OK, I'll whip up a patch for that along with a few other minor DTS fixes.

-- 
nvpublic
