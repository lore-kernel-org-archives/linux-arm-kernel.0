From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 11 Apr 2012 10:57:18 -0500
Subject: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
In-Reply-To: <4F85435C.1060305@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <1323863746-18145-5-git-send-email-rnayak@ti.com>
 <CAB-zwWjSSsR0XMrntkEmHDtgJ_zDxgJh6KX=TsSKggd9mCgsVQ@mail.gmail.com>
 <4F85435C.1060305@ti.com>
Message-ID: <CAB-zwWhFTysfm4-7rY+g8rCOdRK6CAQA0c=+QaOyTxQOvVdLiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 3:39 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Yes, it is a known issue and the fix was unfortunately was not merged during
> -rc phases but is fixed in 3.4 and should be fixed in 3.3 stable branch as
> well. I received the notification from Greg KH 2 weeks ago about the stable:
> Patch "tty: serial: OMAP: Fix oops due to NULL pdata in DT boot" has been
> added to the 3.3-stable tree
>
> You should just switch to 3.4-rc2 or get the patch if you are stuck to 3.3.

Thanks, switching to 3.4-rc kernels fixed the problem (for cramfs),
and right now this works for me.

Regards,

Omar
