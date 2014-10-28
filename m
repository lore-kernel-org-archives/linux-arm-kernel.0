From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 28 Oct 2014 09:27:15 +0100
Subject: [PATCH v4 1/1] ARM: at91/dt: sam9x5: Add CAN device nodes
In-Reply-To: <544692A6.9030509@atmel.com>
References: <1412682710-14219-1-git-send-email-alexander.stein@systec-electronic.com>
 <544692A6.9030509@atmel.com>
Message-ID: <1963737.sgbgq0RFOC@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

On Tuesday 21 October 2014 19:06:46, Nicolas Ferre wrote:
> On 07/10/2014 13:51, Alexander Stein :
> > Add the missing CAN devices node including their pin muxing to the shared
> > .dtsi for at91sam9x5. Actually include this file.
> > While at it, fix white spaces of can1_clk.
> 
> Well, no: I split the patch in two to separate these whitespace
> modifications and the addition of nodes. But now worries, I did it and
> stacked the 2 patches on top of my WIP at91-3.19-dt branch.

It seems this branch is not public, yet. At least I could not find it on git.kernel.org.
Did you also pick "ARM: at91/dt: sam9263: Add CAN device nodes"? (https://www.mail-archive.com/devicetree at vger.kernel.org/msg44970.html)

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein at systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
