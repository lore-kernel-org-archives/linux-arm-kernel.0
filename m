From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Mar 2018 13:48:19 +0000
Subject: [PATCH v3] arm64: signal: Ensure si_code is valid for all fault
 signals
In-Reply-To: <1520530865-26554-1-git-send-email-Dave.Martin@arm.com>
References: <1520530865-26554-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180309134818.GE15537@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thanks for resending this one separately -- I'll pick it up for 4.17.
Just a minor thing:

On Thu, Mar 08, 2018 at 05:41:05PM +0000, Dave Martin wrote:
> Changes since v2:
> 
>  * Rebased to v4.16-rc4.
> 
>  * Split out the SIGFPE related changes (which impact core/x86 code)
>    into a separate series.
> 
> Original blurb:

In future, please put this sort of stuff ^^ after the '---', otherwise I
have to manually remove it from the commit message when committing and
one day I'll end up forgetting.

Cheers,

Will
