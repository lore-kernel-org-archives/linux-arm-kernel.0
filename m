From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 5 Jan 2012 10:46:02 -0800
Subject: [PATCH] ARM: tegra: select required CPU and L2 errata options
In-Reply-To: <6121078.4q2inFFXlB@fb07-iapwap2>
References: <1325719752-818-1-git-send-email-olof@lixom.net>
 <6121078.4q2inFFXlB@fb07-iapwap2>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F172B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Thursday, January 05, 2012 9:30 AM:
> Am Mittwoch, 4. Januar 2012, 15:29:12 schrieb Olof Johansson:
> > Only one of the L2 erratas are needed on T30, but T20/25
> > needs a few more.
> 
> can we have a word from someone from NVIDIA about which Tegra versions/revisions need
> which erratum applied?

Well, I can tell you easily which CPU revisions the various Tegra have.
According to our internal wiki:

Tegra20: CPU r1p1, PL310 r2p0 
Tegra30: CPU A01=r2p7/A02+=r2p9, NEON r2p3-50, PL310 r3p1-50 

You should be able to work out which errata are needed using the ARM
documentation.

-- 
nvpublic
