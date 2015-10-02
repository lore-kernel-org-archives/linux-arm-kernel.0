From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 2 Oct 2015 14:32:49 +0300
Subject: [PATCH 1/2] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock
 Domain for sound
In-Reply-To: <560E6AAE.9080605@cogentembedded.com>
References: <cover.1443752733.git.horms+renesas@verge.net.au>
 <6507c4efd2ca4a3dccedbc5b4724f9faabf97fca.1443752733.git.horms+renesas@verge.net.au>
 <560E6AAE.9080605@cogentembedded.com>
Message-ID: <560E6B61.5000509@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/2/2015 2:29 PM, Sergei Shtylyov wrote:

>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> 484adb005886 ("ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain")
>> added CPG/MSTP clock-cells domain support, but it was missing sound
>> support. This patch adds it.
>
>     Really? I'm only seeing "power-domains" prop added...

    Oh, I understand now. The log seems somewhat poorly worded though...

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> [horms: Updated commit id referred to in changelog]
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
