From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Sep 2016 08:06:49 -0700
Subject: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
In-Reply-To: <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e@ti.com>
 <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
Message-ID: <20160902150648.lgbhxvyapo4p3lg3@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [160902 06:52]:
> On Fri, Sep 2, 2016 at 5:41 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> > Instead, it seems to be easier for maintenance and safer overall if the
> > older version has a file of its own which can be kept alone.
> >
> > Also, how about renaming the existing dts to am57xx-beagle-x15-reva2.dts
> > and let the production version be called am57xx-beagle-x15.dts? Surely
> > this will cause some inconvenience to A2 users. But there are few users
> > of those and it might be more intuitive for the majority users if the
> > file for production version is without a specific version string
> > attached. Just a thought though, not sure about it myself either.
> 
> Nak, let's NOT do that to A2 users.
> 
> The am57xx-beagle-x15.dts went mainline in v3.19, u-boot installed on
> devices would need to be updated and this would make bisecting a pain.
> ;)

I agree, let's keep things working without forcing people to update
their u-boot enviroment for the dtb name.

Regards,

Tony
