From: horms@verge.net.au (Simon Horman)
Date: Wed, 8 Jan 2014 09:07:09 +0900
Subject: [PATCH v3 3/3] ARM: shmobile: genmai: Enable r7s72100-ether
In-Reply-To: <52CC7C1B.20807@cogentembedded.com>
References: <1389061635-4083-1-git-send-email-horms+renesas@verge.net.au>
 <1389061635-4083-4-git-send-email-horms+renesas@verge.net.au>
 <52CC7C1B.20807@cogentembedded.com>
Message-ID: <20140108000709.GC5136@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 02:13:47AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07-01-2014 6:27, Simon Horman wrote:
> 
>    You've removed RFC but still haven't signed off. :-)
> 
> >---
> >v2
> >* As suggested by Magnus Damm and Sergei Shtylyov
> >   - r7s72100 ethernet is not gigabit so do not refer to it as such
> 
> >* As suggested by Sergei Shtylyov
> >   - set no_ether_link as there is no LINK signal documented
> >     in the manual
> 
>    I'm OK with the patch, you can add my Acked-by.

Thanks, will do.
