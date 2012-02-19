From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sun, 19 Feb 2012 20:10:46 +0400
Subject: [PATCH 1/2] ARM: OMAP2+: UART: remove unused fields in
 omap_uart_state.
In-Reply-To: <20120219022931.8254.38314.stgit@notabene.brown>
References: <20120219022841.8254.86264.stgit@notabene.brown>
 <20120219022931.8254.38314.stgit@notabene.brown>
Message-ID: <4F411F06.20006@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-02-2012 6:29, NeilBrown wrote:

> commit 2fd149645eb46d261 removed the last usage of 'can_sleep' but
> did not remove the field.
> commit  8612bd22f3036974 removed the last non-trivial use of 'pdev'.

    Please also specify the summaries of the above commits with them.

> So remove these fields and the one trivial use.

    This seems like the material for 2 patches.

> Acked-by: Govindraj.R <govindraj.raja@ti.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

WBR, Sergei
