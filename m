From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 09:25:56 +0100
Subject: [PATCH v2 3/9] ARM: hisi: enable Hi3519 soc
In-Reply-To: <5669181A.7030105@huawei.com>
References: <1449110565-23590-1-git-send-email-xuejiancheng@huawei.com>
 <4297924.YW2IR8MmHA@wuerfel> <5669181A.7030105@huawei.com>
Message-ID: <2026764.asVhbiLgfn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 14:13:46 xuejiancheng wrote:
> 
> On 2015/12/9 23:32, Arnd Bergmann wrote:
> > On Tuesday 08 December 2015 11:03:20 xuejiancheng wrote:
> >>>>

> >>> Yes. It's correct. They may share some IP blocks. But they may be very different
> >>> from the new one for the arch code. I also don't think it's a good idea to make
> >>> them share the same name.
> >>
> >> I will use ARCH_HISI instead of ARCH_HI3519.
> >>
> >>
> > 
> > Do you mean you want to remove the other options as well?
> > 
> > We should do this consistently at least within the Kconfig file.
> 
> I think it is ideal if we can do that.  But I won't change it in HI3519 soc patch.
> 
> I will just use ARCH_HISI for HI3519 this time.
> 

Ok, sounds good.

	Arnd
