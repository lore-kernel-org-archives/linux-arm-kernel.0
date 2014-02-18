From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 18 Feb 2014 12:41:30 +0900
Subject: [PATCH v4 0/2] [RESEND] Lager and Koelsch reference serial port
 support
In-Reply-To: <1392150878-10436-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392150878-10436-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CANqRtoSG_aD7EkUoEPKGk3NsjKihXiMhuKw8nAe-G86sFL+VuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Feb 12, 2014 at 5:34 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> This patch set enables the serial port DT devices for the Lager and Koelsch
> reference boards.
>
> The previous "[PATCH v3 0/4] Lager and Koelsch reference serial port support"
> series that contained these two patches got partially merged in v3.14-rc1. This
> is a resent of the left-overs that we have decided to push back to v3.15,
> rebased on top of Simon's latest devel branch.
>
> Laurent Pinchart (2):
>   ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
>   ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT

Thanks for your efforts. As discussed earlier, to minimize amount of
churn and risk of short term breakage it is probably wise to wait with
this series until we have removed legacy board support. My goal is
still to be able to merge this in v3.15 but if that is possible or not
depends on how well our DT reference migration efforts will go.

Cheers,

/ magnus
