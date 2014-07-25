From: nm@ti.com (Nishanth Menon)
Date: Fri, 25 Jul 2014 10:44:10 -0500
Subject: [PATCH 2/2] ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp
 interface lists
In-Reply-To: <53D276A0.3070800@ti.com>
References: <1405499774-19770-1-git-send-email-lokeshvutla@ti.com>
 <1405499774-19770-3-git-send-email-lokeshvutla@ti.com>
 <53CE9652.4080304@ti.com> <53D276A0.3070800@ti.com>
Message-ID: <CAGo_u6qGYzndVDHxjkoBgfV+adw1FXbhBfRxVPQV2jYq5gt0gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 10:24 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>
> After looking closely into it, I realized that currently its the same logic of what you are
> suggesting.  If there is no error from registering common lists then only go for registering the
> Soc specific lists.
> Do you still want me to go ahead and make this change?


Sure. Ok with me at least.

-- 
---
Regards,
Nishanth Menon
