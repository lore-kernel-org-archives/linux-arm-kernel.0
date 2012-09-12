From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 12 Sep 2012 14:36:18 -0700
Subject: [PATCHv7 06/12] ARM: OMAP4: suspend: Program all domains to
 retention
In-Reply-To: <1342704392-23657-7-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Thu, 19 Jul 2012 16:26:26 +0300")
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-7-git-send-email-t-kristo@ti.com>
Message-ID: <878vcex6st.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [Jean Pihet <j-pihet@ti.com>: ported on top of the functional power
> states]
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Paul, go ahead and queue this one with the others.

Kevin
