From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 14 May 2018 18:57:04 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77990: Add GPIO device nodes
In-Reply-To: <20180514143032.fxk4gcww6xihilrl@verge.net.au>
References: <20180513090855.25982-1-horms+renesas@verge.net.au>
 <e9646f33-9a82-f3ea-c4a6-cd2469b7658a@cogentembedded.com>
 <20180514143032.fxk4gcww6xihilrl@verge.net.au>
Message-ID: <d232d79b-2d95-9938-bc1c-55b705c455c8@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2018 05:30 PM, Simon Horman wrote:

>>> The compat string renesas,gpio-rcar has been deprecated since v4.14,
>>> the same release that r8a77990 SoC support was added. Thus
>>> renesas,gpio-rcar can safely be removed without any risk of behaviour
>>> changes between old and new mainline kernels and DTBs.
>>
>>    This hardly matches the subject. :-)
> 
> Indeed, I will resubmit.

   I'm seeing this patch merged on Sunday...

>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> [...]

MBR, Sergei
