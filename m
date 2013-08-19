From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 19 Aug 2013 20:23:06 +0530
Subject: [PATCH 1/2] include: dt-binding: input: create a DT header
 defining key codes.
In-Reply-To: <52092299.4080104@wwwdotorg.org>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com>
 <52014E50.6030508@wwwdotorg.org> <5203D138.4030107@nvidia.com>
 <20130808171331.GA6960@core.coreip.homeip.net>
 <5203D487.5020507@wwwdotorg.org>
 <20130812171504.GA31418@core.coreip.homeip.net>
 <52092299.4080104@wwwdotorg.org>
Message-ID: <52123152.9070408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 August 2013 11:29 PM, Stephen Warren wrote:
> On 08/12/2013 11:15 AM, Dmitry Torokhov wrote:
>>>
>>> Device tree files can only include headers in include/dt-bindings.
>>> Eventually/soon, all the DT files and the headers in the dt-bindings/
>>> directory will be split out into a separate git tree, which does not
>>> have access to include/uapi, or indeed any other Linux kernel header files.
>> OK, that makes it easier for me - please merge through whatever tree
>> that owns include/dt-bindings.
> Are there any objections to my taking both patches through the Tegra
> tree? Patch 2/2 depends on 1/2 and is Tegra-specific. This should work
> out fine unless anyone else wants to use the new header this kernel
> cycle; if they do, this should go into a topic branch in the DT tree
> that I can pull into the Tegra tree.

Hi Stephen,
Just wanted to check if you are taking this on Tegra tree. I want to 
post some more cleanups on other dts file  to use dt-binding include for 
key code otherwise I will defer for next kernel version.


Thanks,
Laxman
