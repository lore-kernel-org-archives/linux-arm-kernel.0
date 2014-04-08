From: horms@verge.net.au (Simon Horman)
Date: Tue, 8 Apr 2014 09:29:12 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: Add EHCI MSTP clock
In-Reply-To: <5342890C.8090703@cogentembedded.com>
References: <20140407060421.25826.64819.sendpatchset@w520>
 <5342890C.8090703@cogentembedded.com>
Message-ID: <20140408002911.GC30496@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 03:16:28PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07-04-2014 10:04, Magnus Damm wrote:
> 
> >From: Magnus Damm <damm@opensource.se>
> 
> >Add support for EHCI clock gating via the MSTP703 bit on r8a7791.
> 
> >Signed-off-by: Magnus Damm <damm@opensource.se>
> 
>    I have already posted such patch at end of the last week.

Thanks for giving me the luxury of having two patches to choose from:
much better than none. I regret that there could only be one winner :^)

Ordinarily I would take the first one, Sergei's. But I have
decided to take Magnus's as it is simpler due to not cleaning
up the code at the same time as adding the feature described on the wrapper.
