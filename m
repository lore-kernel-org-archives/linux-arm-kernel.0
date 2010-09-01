From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 02 Sep 2010 08:49:08 +0900
Subject: [PATCH 0/2] s3c: mach-real6410 missing fixes
In-Reply-To: <AANLkTinJVKmAV_ZXDXTqOwbu4iTmrf9fRVpZ3uCdDr1w@mail.gmail.com>
References: <20100816173905.14924.62664.stgit@darius-desktop>
	<4C721CF0.3070004@gmail.com>
	<005b01cb45b2$7c4f5420$74edfc60$%kim@samsung.com>
	<4C7B57F4.8010502@gmail.com>
	<012c01cb4978$193f67c0$4bbe3740$%kim@samsung.com>
	<AANLkTinJVKmAV_ZXDXTqOwbu4iTmrf9fRVpZ3uCdDr1w@mail.gmail.com>
Message-ID: <002a01cb4a30$47d5f140$d781d3c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> On Wed, Sep 1, 2010 at 4:50 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Darius Augulis wrote:
> >>
> >> Hi,
> >>
> > Hi ;-)
> >
> >> On 08/27/2010 09:38 AM, Kukjin Kim wrote:
> >> > Darius Augulis wrote:
> >> >>
> >> >> Hi Ben, Kukjin,
> >> >>
> >> > Hi Darius,
> >> >
> >> >> please add these patches to your tree, they contain necessary fixes
for
> >> >> mach-real6410.
> >> >>
> >> > Looks good your patches.
> >> >
> >> > But I think, this should be sent to upstream through Ben's tree.
> >> >
> >> > If Ben has no time to handle this, I will do it through my tree.
> >>
> >> it seems he hasn't. please pick up these two patches and older one,
with
> >> fixup of device name of samsung serial. it hangs already for a long
time
> >> without any comment.
> >
> > I have a question about dm9000 on your real6410.
> >
> > The smdkv210 use it also, but need to some modify dm9000 driver for use
it.
> > Is there no problem on your board?
> 
> this patch is not driver fix. dm9000 on real6410 is working well and
> tested several times.
> so, please add this patch to your tree too. if you found some bug in
> dm9000 driver or if you need new features please provide new patch.
> 
Yeah I know, yours is not driver fix.
I did just wonder working of dm9000.

Because there was some problem on my board as following.
The dm9000 Phy enable was required at that time.
Ethernet did not work without dm9000 Phy enable.

But couldn't find the root cause and because that is not general in my
thinking, not submitted.

> >
> > And please refer to my other comment about device name of Samsung
serial.
> >
> > Ben,
> > I will apply Darius' fixing CodingStyle patch.
> > If any problems, please let me know.
> >
> >>

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
