From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Dec 2011 09:44:52 +0900
Subject: [rtc-linux] Re: [PATCH v2 0/4] Implement RTC support for
 S3C2443/S3C2416/S3C2450
In-Reply-To: <20111226020119.2c57a26e@linux.lan.towertech.it>
References: <201112121543.42299.heiko@sntech.de>
 <064801ccbfb1$c5d48e60$517dab20$%kim@samsung.com>
 <201112210922.12300.heiko@sntech.de> <20111223114300.GA13175@sirena.org.uk>
 <20111226020119.2c57a26e@linux.lan.towertech.it>
Message-ID: <08e301ccc430$beb4dc60$3c1e9520$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alessandro Zummo wrote:
> 
> On Fri, 23 Dec 2011 11:43:00 +0000
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > Who is Andrew and should I include him in the recipients? I only found
> > > Alessandro Zummo in the MAINTAINERS file for rtc stuff and am lacking
> any
> > > comment from the rtc-side until now.
> >
> > Andrew Morton.  Alessandro hasn't been terribly active for a while now.
> 
>  But I'm still keeping an eye on the patches ;)
> 
Hi Alessandro,

Good to see you again :)

Please check next-samsung-devel-rtc branch in my tree,
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

And if you're ok to send to upstream via samsung tree, please let me know so
that I can add your ack on rtc patches. Of course, if any problems, let me
revert them and they should be re-worked.

As a note, it depends on next-samsung-devel-dt1 which includes support
device tree for Samsung stuff, so I rebased on it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
