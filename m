From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 20 Jan 2012 21:45:15 +0300
Subject: [PATCH v2] DaVinci: can only power up domains on DM644x
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B7265471@DFLE34.ent.ti.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
 <201201062140.33712.sshtylyov@ru.mvista.com>
 <201201062148.32025.sshtylyov@ru.mvista.com>
 <3E54258959B69E4282D79E01AB1F32B7265471@DFLE34.ent.ti.com>
Message-ID: <4F19B63B.1020306@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/12/2012 03:00 PM, Karicheri, Muralidharan wrote:

> Sekhar & Sergei,

> This will affect the new SoCs that have capabilities to power up different domains. Why do we need this enforcement? We are working on a DaVinci variant SoC that can do power up multiple domains

    Will their power-up procedure be the same as for DM644x?

> (That is why I had a patch earlier to support
> Multiple PD which is already part of the tree). So I don't want this patch to go through unless I see a reason for pushing this.

    Why you didn't voice your concern when Sekhar has suggested this approach?

> Murali Karicheri
> Software Design Engineer
> email: m-karicheri2 at ti.com

WBR, Sergei
