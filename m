From: s.peter@mpl.ch (Stefan Peter)
Date: Tue, 27 Nov 2012 21:57:24 +0100
Subject: [PATCH v3 2/4] ARM: kirkwood: DT board setup for Network Space
 v2 and parents
In-Reply-To: <20121127111454.GG8628@kw.sim.vm.gnt>
References: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
 <1350468546-25901-3-git-send-email-simon.guinot@sequanux.org>
 <20121126090253.GI9580@quad.lixom.net> <20121126151811.GF8628@kw.sim.vm.gnt>
 <20121126160449.GD15800@titan.lakedaemon.net>
 <20121127111454.GG8628@kw.sim.vm.gnt>
Message-ID: <50B52934.4090705@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.11.2012 12:14, Simon Guinot wrote:
> On Mon, Nov 26, 2012 at 11:04:49AM -0500, Jason Cooper wrote:
>> On Mon, Nov 26, 2012 at 04:18:11PM +0100, Simon Guinot wrote:
>>> On Mon, Nov 26, 2012 at 01:02:53AM -0800, Olof Johansson wrote:

>>>>> +config MACH_NETSPACE_MAX_V2_DT
>>>>> +	bool "LaCie Network Space Max v2 NAS (Flattened Device Tree)"
>>>>> +	select ARCH_KIRKWOOD_DT
>>>>> +	help
>>>>> +	  Say 'Y' here if you want your kernel to support the LaCie
>>>>> +	  Network Space Max v2 NAS, using Flattened Device Tree.
>>>>
>>>> It would be nice to get away from these config options. The whole point with
>>>> device tree is to no longer have to do code changes for new similar boards.
>>>>
>>>> And even then, since they share the same init function, there's no need for
>>>> three options, just one.
>>>>

>>>
>>> I will send a patch to remove this options.

>> No need to jump on it just yet.  Nothing more is going into 3.8.  We
>> plan on cleaning up a lot of this as the first part of stuff for 3.9.
>> It'll be easier to have one series knocking it all out as opposed to
>> several board-specific patches from individuals.
> 
> About the config duplicate options, I think that the ns2 is the only
> problem. But if you plan to remove the board-*.c files for 3.9, maybe
> there is no need at all to fix the issue ?
>  

Are there any plans to convert the existing non-DT kirkwood boards in
3.9, too?

Regards

Stefan Peter

-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
