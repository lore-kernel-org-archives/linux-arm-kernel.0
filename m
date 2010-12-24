From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 24 Dec 2010 14:25:41 +0300
Subject: [PATCH v2] davinci: Add additional JTAG code for AM-1808 and
	OMAP-L138 Rev 2.0 SoCs
In-Reply-To: <1293132288-22325-1-git-send-email-michael.williamson@criticallink.com>
References: <1293132288-22325-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4D148335.8070209@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-12-2010 22:24, Michael Williamson wrote:

> From: Sudhakar Rajashekhara<sudhakar.raj@ti.com>

> The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
> In addition, the variant code for the AM-1808 SoC appears to match
> the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
> these chips.

> This patch is orignally from a patch on the arago project, here:
> http://arago-project.org/git/projects/?p=linux-omapl1.git;a=commit;h=6157618435e313a444cdf059702bd34036a6e2b7

> Further information related to the need for this patch can be located at
> http://e2e.ti.com/support/embedded/f/354/p/67290/248486.aspx
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-November/021224.html

> This patch was tested using an AM-1808 SoC on a MityARM-1808 SoM card.  It
> was also tested using a Rev 1.0 silicon OMAP-L138 on a MityDSP-L138F card.

> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> Tested-by: Michael Williamson <michael.williamson@criticallink.com>
> Reported-by: Nicolas Luna <luna.id@gmail.com>

    I saw that the original patch was signed off by Sudhakar -- why you 
omitted that?

WBR, Sergei
