From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 06 Feb 2013 10:05:22 +0800
Subject: [PATCH] ARM:omap2: using strlcpy instead of strncpy
In-Reply-To: <20130205185648.GM25185@atomide.com>
References: <51090829.1010109@asianux.com>
 <20130201224546.GG22517@atomide.com> <510F78AB.4000602@ti.com>
 <20130204181844.GP22517@atomide.com> <51106BF2.7080203@asianux.com>
 <20130205185648.GM25185@atomide.com>
Message-ID: <5111BA62.8050908@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?02?06? 02:56, Tony Lindgren ??:
> * Chen Gang <gang.chen@asianux.com> [130204 18:22]:
>> >   Does it mean: we need not sync MAINTAINERS file for twl-*, recently ?
>> > 
>> >   :-)
> No we should still do it.
> 
> Tony
> 

  ok, thanks.

  if necessary (no other members do it), I should perform.
  if really should I do:

    requirements:
      A) I should succeed provide at least 3 valuable patches to twl-*
           (or I am not qualified to provide the sync MAINTAINERS patch)

      B) relative member need give strictly checking for the patch.
           (so can evaluate whether I have been qualified)

      C) it is necessary to be monitored by the relative mailing lists.

    I should try:
      A) need mainly focus on the omap2, specially for twl-*

      B) the patch type should be for bug fixing:
           (I am not familiar with omap2, so can not for new features)
          i. memory override.
         ii. resource management.
        iii. others (compiling issue, type cast, ...)

      C) should provide 3 twl-* valuable patches within 1 month.
           (have finished one: strlcpy, in Jan 30 2013)
           (so need finish the other 2 patches, before Feb 28 2013)

    hope I can succeed.

    welcome any members to provide suggestions and completions.


  thanks.

  :-)

-- 
Chen Gang

Asianux Corporation
