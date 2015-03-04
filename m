From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 04 Mar 2015 16:44:00 +0000
Subject: [PATCH REPOST 0/2] Remove pl011 startup glitches and avoid dummy
 TX during startup
In-Reply-To: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <54F73650.2070304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 04/03/15 12:27, Dave P Martin wrote:
> There have been no comments on this series since my previous post, and
> I have made no further changes.
> 
> Since then, I have confirmed that this also works robustly with TX DMA
> enabled on Juno.
> 
> Review/comments/testing still welcome.

this has been tested briefly on a Calxeda Midway without any
regressions. Also I use them as the base for my SBSA series now (which
are tested on the model and the Midway) and I see that all problems
observed before are gone now.

Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.
