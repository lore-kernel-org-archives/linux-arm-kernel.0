From: joelf@ti.com (Joel Fernandes)
Date: Wed, 7 May 2014 16:48:33 -0500
Subject: [PATCH 02/26] ARM: OMAP: dmtimer: Add comments on OMAP1 clock
 framework
In-Reply-To: <20140507152004.GC9502@atomide.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
 <1398375849-6017-3-git-send-email-joelf@ti.com>
 <20140507152004.GC9502@atomide.com>
Message-ID: <536AAA31.6080905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2014 10:20 AM, Tony Lindgren wrote:
> * Joel Fernandes <joelf@ti.com> [140424 14:44]:
>> OMAP1 doesn't support clock framework, add a comment where needed
>> and correct a FIXME.
> 
> This is at least a wrong comment, the original comment seems right
> to me.

Can you elaborate a bit more please on the wrongness of the comment?

I can change the comment to say "common clock" instead of "clock" if
that's the only problem here.

 thanks,

-Joel
