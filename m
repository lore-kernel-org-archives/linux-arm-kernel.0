From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 26 Jan 2012 15:31:14 +0400
Subject: [PATCH 12/21] OMAP3+: SR: introduce class init,deinit and priv
 data
In-Reply-To: <1327504583-13408-13-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-13-git-send-email-j-pihet@ti.com>
Message-ID: <4F213982.9020601@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> Certain class drivers such as class 1.5 drivers, will need specific
> notification that they have to be inited up or deinited independent
> of smart reflex operation. They also may need private data to be
> used for operations of their own, provide the same.
> This allows the class driver to initialize it's internal data structures
> on a need basis in preparation for the specific domain's autocomp usage.
> The resultant operation is as follows:
> when autocomp is set to 1 ->  class drivers' init is called
> The existing enable/disable is still used as before by the SmartReflex
> core driver to enable disable the class operation.
> When autocomp is set to 0 ->  class drivers' deinit is called, signaling
> the end of usage for that domain.

> Change-Id: Ie6a4b163d52af4931a4506ed7a3a6b752173a674

    Please remove this line.

> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>

WBR, Sergei
