From: nm@ti.com (Menon, Nishanth)
Date: Fri, 1 Jun 2012 05:18:26 -0500
Subject: [PATCHv6 13/14] ARM: OMAP3: vc: auto_ret / auto_off support
In-Reply-To: <1338472550-20743-14-git-send-email-t-kristo@ti.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
 <1338472550-20743-14-git-send-email-t-kristo@ti.com>
Message-ID: <CAOMWX4cJWjV+unHfJiDqeVSnAyN0gP+N0emG_iKPYsgwaGu7jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 8:55 AM, Tero Kristo <t-kristo@ti.com> wrote:
>
> + ? ? ? case PWRDM_POWER_RET:
Apologies on hijacking this thread, but I do think we need to revisit
this series after rebase
on top of Jean's series - it otherwise results a mess of different
sets of macros.

IMHO though, it might be a good time to discuss if we would like to
switch from macros to
enums to become as much as possible type safe in usage - it is just
too easy for later
developers who will maintain this code from mistakenly using wrong
macros at the wrong
place and causing others to spend weeks debugging?

Regards,
Nishanth Menon
