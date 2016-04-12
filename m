From: dawei.chien@mediatek.com (dawei chien)
Date: Tue, 12 Apr 2016 10:32:50 +0800
Subject: [PATCH v6 0/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
In-Reply-To: <1458623586.674.2.camel@mtksdaap41>
References: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
 <20151217015231.GC3496@ubuntu> <1458017620.30412.3.camel@mtksdaap41>
 <20160315061709.GC13831@vireshk-mac-ubuntu>
 <1458623586.674.2.camel@mtksdaap41>
Message-ID: <1460428370.25776.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-22 at 13:13 +0800, dawei chien wrote:
> On Tue, 2016-03-15 at 13:17 +0700, Viresh Kumar wrote:
> > On 15-03-16, 12:53, dawei chien wrote:
> > > On Thu, 2015-12-17 at 09:52 +0800, Viresh Kumar wrote:
> > > > On 16-12-15, 21:29, Dawei Chien wrote:
> > > > > Use Intelligent Power Allocation (IPA) technical to add dynamic power model
> > > > > for binding CPU thermal zone. The power allocator governor allocates power
> > > > > budget to control CPU temperature.
> > > > >
> > > > > Power Allocator governor is able to keep SOC temperature within a defined
> > > > > temperature range to avoid SOC overheat and keep it's performance.
> > > > > mt8173-cpufreq.c need to register its' own power model with power allocator
> > > > > thermal governor, so that power allocator governor can allocates suitable
> > > > > power budget to control CPU temperature.
> > > > >
> > > > > Binding document is refer to this patchset
> > > > > https://lkml.org/lkml/2015/11/30/239
> > > > >
> > > > > Change since V5:
> > > > > 1. Remove thermal sensor ID from phandles
> > > > 
> > > > Though you should have included this in the new version, but still
> > > > 
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > 
> > > > --
> > > > viresh
> > > 
> > > Hi Viresh,
> > > Would you please pull this patch to your tree since following patch
> > > already pulled in, thank you.
> > > 
> > > https://lkml.org/lkml/2015/11/30/239
> > 
> > Its Rafael, who is going to apply this one.
> > 
> > Can you please resend it as he may not have it in patchworks?
> > 
> 
> Hi Rafael,
> Would you merge this patch to your tree, thank you.
> 
> BR,
> Dawei

Hi Rafael,
Would you please merge this patch, or please kindly let me know for any
problem, thank you.
 
BR,
Dawei
