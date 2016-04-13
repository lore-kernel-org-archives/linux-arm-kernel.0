From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 13 Apr 2016 07:32:15 -0500
Subject: [PATCH 1/6] of/irq: Export of_msi_get_domain
In-Reply-To: <1460543456-11345-2-git-send-email-mbrugger@suse.com>
References: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
 <1460543456-11345-2-git-send-email-mbrugger@suse.com>
Message-ID: <CAL_JsqJ9fc8SOG9Gb_gcuSH0NT6HEy8P1O2kSSxV1y3+3a3N1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 5:30 AM, Matthias Brugger <mbrugger@suse.com> wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> Export of_mis_get_domain to enable it for users from outside.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
