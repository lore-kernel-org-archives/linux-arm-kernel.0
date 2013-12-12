From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Dec 2013 16:23:26 -0800
Subject: [PATCH] ARM: at91: remove redundant dependency
In-Reply-To: <1386259208-2239-1-git-send-email-nicolas.ferre@atmel.com>
References: <1384932191-8967-1-git-send-email-michael.opdenacker@free-electrons.com>
 <1386259208-2239-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20131212002326.GA21531@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 05:00:08PM +0100, Nicolas Ferre wrote:
> From: Yanis Moreno <yanis.moreno63@gmail.com>
> 
> This removes the "depends on SOC_SAM_V7" statement
> in a Kconfig section that's under an "if SOC_SAM_V7"
> condition (same parameter).
> 
> Signed-off-by: Yanis Moreno <yanis.moreno63@gmail.com>
> Reviewed-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Olof,
> 
> This is an additional patch for cleanup. I didn't include it in my previous
> "cleanup" branch as I had wanted to keep it focused on the move to CCF.
> 
> As you said that you are okay with applying patches and that I have only one
> related to "cleanup" for the moment, I send it to you.

Applied. Thanks.

-Olof
