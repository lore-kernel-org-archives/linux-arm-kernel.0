From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 19 Nov 2012 16:30:59 +0400
Subject: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
In-Reply-To: <1353288254-6211-2-git-send-email-horms@verge.net.au>
References: <1353288254-6211-1-git-send-email-horms@verge.net.au>
 <1353288254-6211-2-git-send-email-horms@verge.net.au>
Message-ID: <50AA2683.1070502@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-11-2012 5:24, Simon Horman wrote:

> From: Bastian Hecht <hechtb@gmail.com>

> Since commit 3c7ea4eccfd2e

    Please also specify that commit summary in parens.

> the sh_flctl driver requires the error IRQ line to
> signal failed transactions between the flash controller and the NAND chip.
> This information is mandatory - else the driver refuses to start up. We
> provide it here for the board mackerel.

> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

WBR, Sergei
