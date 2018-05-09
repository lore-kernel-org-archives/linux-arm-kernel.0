From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 9 May 2018 22:18:47 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77980: add resets property CAN-FD
 node
In-Reply-To: <20180509191435.vm2zfuuixbyd3drm@verge.net.au>
References: <20180509175409.10507-1-horms+renesas@verge.net.au>
 <CAMuHMdXWHXtO1-0FucCsPTE22U_k+vdqCrDHgBFrM4+yEgXYcQ@mail.gmail.com>
 <20180509191435.vm2zfuuixbyd3drm@verge.net.au>
Message-ID: <2889c7ff-1748-e435-c03c-cb36cf930b1d@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/9/2018 10:14 PM, Simon Horman wrote:

>>> Add resets property to CAN-FD node to describe it in the reset topology of
>>> on-SoC devices.  This allows to reset the CAN-FD device using the Reset
>>> Controller API.
>>>
>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks, applied.

    You're too quick (and I'm on holiday today). Need "to| before "CAN-FD" in 
the subject. ;-)

MBR, Sergei
