From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 27 Jan 2012 09:09:33 +0000
Subject: [PATCH v1 3/3] ARM: tegra: cpuidle driver for tegra
In-Reply-To: <20120126191134.GA23484@sirena.org.uk>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
 <1327594923-21822-4-git-send-email-pdeschrijver@nvidia.com>
 <20120126191134.GA23484@sirena.org.uk>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433179202C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 00:41:34, Mark Brown wrote:
> On Thu, Jan 26, 2012 at 06:22:03PM +0200, Peter De Schrijver wrote:
> > CPUidle driver for tegra. In this version only LP3 (clockgating) is supported.
> 
> Are you aware of the work Rob Lee is doing on providing a common library
> for the ARM generic bits of cpuidle?  I really must convert the s3c64xx
> work I did on that over some time...

Slightly off-topic..

This is probably a bit early to ask but when it that likely to get merged?
I am working on cpuidle for AM33xx and if Rob's cpuidle consolidation is getting
merged soon I will try to use them in my baseline.
