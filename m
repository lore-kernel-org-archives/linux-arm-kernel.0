From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 09:18:26 -0700
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <20130306081401.GN27241@tbergstrom-lnx.Nvidia.com>
References: <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
 <20130226181114.GU17833@n2100.arm.linux.org.uk>
 <5130E757.6090500@wwwdotorg.org>
 <20130304063436.GB27241@tbergstrom-lnx.Nvidia.com>
 <20130304091600.GC27241@tbergstrom-lnx.Nvidia.com>
 <5134D50B.8060001@wwwdotorg.org>
 <20130305074047.GH27241@tbergstrom-lnx.Nvidia.com>
 <513624AA.4090207@wwwdotorg.org>
 <20130306081401.GN27241@tbergstrom-lnx.Nvidia.com>
Message-ID: <51376C52.8050007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2013 01:14 AM, Peter De Schrijver wrote:
...
> I was under the
> impression there is no way to know if you're running in secure mode
> or non-secure mode.

There's no ARM-architected way. Given Tegra's implementation, there are
apparently some registers that behave differently that we can use (e.g.
read value values in secure mode, 0xffffffff in non-secure etc.)
