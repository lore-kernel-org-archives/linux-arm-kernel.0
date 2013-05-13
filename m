From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 13 May 2013 17:17:48 +0400
Subject: [PATCH] ARM: shmobile: r8a7778: correct model name in Kconfig
In-Reply-To: <20130513013320.GD7826@verge.net.au>
References: <201305090405.41053.sergei.shtylyov@cogentembedded.com>
 <20130510082055.GB27435@verge.net.au> <518D4CCF.5040706@cogentembedded.com>
 <87obcfn350.wl%kuninori.morimoto.gx@renesas.com>
 <20130513013320.GD7826@verge.net.au>
Message-ID: <5190E7FC.5040809@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-05-2013 5:33, Simon Horman wrote:

>>>>> The correct model name is R-Car M1A or R8A77781; R8A77780 corresponds to R-Car
>>>>> M1S which is a SH based SoC.

>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>> Morimoto-san,

>>>> please review this change.


>>>      This patch was based on the info found on this official Renesas webpage:

>>> http://www.renesas.eu/applications/automotive/cis/cis_highend/rcar_m1as/index.jsp

>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


> Thanks, I have queued-up the following in the soc-r8a7778 branch.
> There was a trivial conflict which I resolved. Please let me know
> if I messed it up.

    It's alright, thanks. I'm just not sure this fix is worth deferring 
for several more months...

WBR, Sergei
