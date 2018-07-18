From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Jul 2018 11:28:25 +0530
Subject: [PATCH 3/6] arm64: dts: hisilicon: Add missing cooling device
 properties for CPUs
In-Reply-To: <5B09A5B4.4050904@hisilicon.com>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <0754957a2c3842cf4e36fa27231d327fd8d6d499.1527225682.git.viresh.kumar@linaro.org>
 <5B09A0B4.2080400@hisilicon.com> <5B09A5B4.4050904@hisilicon.com>
Message-ID: <20180718055825.nrh7wk3cfuvib2ng@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26-05-18, 19:21, Wei Xu wrote:
> Hi Viresh,
> 
> On 2018/5/26 19:00, Wei Xu wrote:
> > Hi Viresh,
> > 
> > On 2018/5/25 6:40, Viresh Kumar wrote:
> >> The cooling device properties, like "#cooling-cells" and
> >> "dynamic-power-coefficient", should either be present for all the CPUs
> >> of a cluster or none. If these are present only for a subset of CPUs of
> >> a cluster then things will start falling apart as soon as the CPUs are
> >> brought online in a different order. For example, this will happen
> >> because the operating system looks for such properties in the CPU node
> >> it is trying to bring up, so that it can register a cooling device.
> >>
> >> Add such missing properties.
> >>
> >> Do minor rearrangement as well to keep ordering consistent.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Thanks!
> > Applied to the hisilicon fix tree.
> 
> Sorry for the noise!
> It seems this patch is still under discussion.
> I will drop it firstly.

Wei, can you please apply it again now that all the discussions are
over ?

-- 
viresh
