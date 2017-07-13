From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 13 Jul 2017 17:52:12 +0100
Subject: APM smmu implementation
In-Reply-To: <CAL85gmBwZ1RGa8my3L1psD0xn2CiJvgDy1SniY27BkJHVD8B1Q@mail.gmail.com>
References: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
 <d9e40de8-82e2-0f19-5b99-d756ded21e80@arm.com>
 <20170109120300.GC21398@arm.com>
 <9d083b5e-0fe4-b649-c4f4-e1005feb9ec1@arm.com>
 <CAL85gmCM-=iTbK3mcsFOtJrxbYFE99FWn7Aj9w-JLhMu03wWqQ@mail.gmail.com>
 <f8cefa15-9d1b-ae92-b673-3010875ac16b@redhat.com>
 <CAL85gmBoE+AXoaVaSuimvX=aPRSEhMXoHvaEZPAvLxzaYSUvSQ@mail.gmail.com>
 <d571ed74-3a89-a6ba-6350-1be181405366@arm.com>
 <CAL85gmBwZ1RGa8my3L1psD0xn2CiJvgDy1SniY27BkJHVD8B1Q@mail.gmail.com>
Message-ID: <20170713165212.GA4228@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 09:08:38AM -0700, Feng Kan wrote:

[...]

> > Cavium are not using MMU-500 - the ThunderX SMMU is their own in-house
> > microarchitecture (with its own bugs and foibles), hence it rightly gets
> > its own implementation identifier. I think Lorenzo has plans to wire up
> > support for the IORT "Device memory address size limit" field, which is
> > the correct way for ACPI to describe the upstream bus width of your
> > MMU-500 integration (and all the other IOMMU integrations facing the
> > same issue).
> This is great, thanks.
> 
> Lorenzo, May I ask when will this be ready. We would very much like
> this change to push out into the latest CentOS release.

I should be able to post a patch at v4.13-rc1 aiming for v4.14.

Lorenzo
