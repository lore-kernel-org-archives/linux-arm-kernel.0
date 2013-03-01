From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Mar 2013 11:25:45 -0700
Subject: [PATCH 1/2] ARM: Tegra: Add clock entry for smp_twd clock
In-Reply-To: <20130228200415.GA17598@avionic-0098.mockup.avionic-design.de>
References: <1362037381-4730-1-git-send-email-pgaikwad@nvidia.com>
 <512F9F59.5030702@wwwdotorg.org>
 <20130228200415.GA17598@avionic-0098.mockup.avionic-design.de>
Message-ID: <5130F2A9.7000609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2013 01:04 PM, Thierry Reding wrote:
> On Thu, Feb 28, 2013 at 11:18:01AM -0700, Stephen Warren wrote:
>> On 02/28/2013 12:43 AM, Prashant Gaikwad wrote:
>>> As DT support for clocks and smp_twd is enabled, add clock
>>> entry for smp_twd clock to DT.
>> 
>> Is this a cleanup for 3.10, or a bug-fix for 3.9? Perhaps it
>> solves the "twd: clock not found" bug I reported?
> 
> Yes. This is pretty much identical to the patch I sent a few days
> ago before your patch that fixed the clock drivers to match the
> devicetree binding documentation.
> 
> The "clock not found" is exactly what this fixes.

OK. I'll forward these patches to arm-soc as fixes for 3.9 then. I
tested them and they work for me, on top of Linus' latest master.
