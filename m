From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 22:13:13 -0700
Subject: [PATCH v2 0/5] ARM: vexpress: TC2 MCPM/SPC again, the complete
 series
In-Reply-To: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
References: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130814051313.GB16635@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 04:09:43PM +0100, Pawel Moll wrote:
> Hi Olof,
> 
> A couple of iterations later and it seems we have solution.
> SCC bindings are back and SPC driver is simply getting
> the base address from the TC2 PM code during the initialization.
> 
> That way we've got clean situation now, and can make proper
> MFD driver for SCC in future. As I said - all your changes are folded
> into the original patches.
> 
> Lorenzo tested the series and it still works, so this time (hopefully)
> we're ready for 3.12...
> 
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
> 
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/pawelmoll/linux.git tags/tc2-pm

Thanks, pulled.


-Olof
