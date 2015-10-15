From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 15 Oct 2015 11:36:19 -0700
Subject: [PATCH v2 7/7] clk: ns2: add clock support for Broadcom Northstar
 2 SoC
In-Reply-To: <6398606.WW44dcgQDV@wuerfel>
References: <1444770485-11210-1-git-send-email-jonmason@broadcom.com>
 <6427519.eIBEvCNlle@wuerfel> <561EB10B.40502@broadcom.com>
 <6398606.WW44dcgQDV@wuerfel>
Message-ID: <561FF223.2050807@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon,

Can you add this to your patchset and change COMMON_CLK_IPROC to a 
silent option?

On 15-10-14 01:16 PM, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 12:46:19 Scott Branden wrote:
>>>
>>> My patch fixes it by always selecting COMMON_CLK_IPROC from
>>> ARCH_BCM_CYGNUS. I wasn't sure whether you want COMMON_CLK_IPROC
>>> to still be user-selectable, so I left that in place. Normally
>>> I'd expect it to be a silent option though, that just gets
>>> implicitly enabled whenever a platform that needs it is built
>>> into the kernel.
>> COMMON_CLK_IPROC can be a silent option and selected as Arnd has done below.
>
> Ok, please do that then. If you want to apply my patch directly,
> you can remove that last paragraph from the description.
>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Scott Branden <sbranden@broadcom.com>
>
> Thanks for taking a look!
>
> 	Arnd
>
