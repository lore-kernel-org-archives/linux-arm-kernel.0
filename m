From: robherring2@gmail.com (Rob Herring)
Date: Thu, 10 Apr 2014 10:21:35 -0500
Subject: [PATCH 1/2] ARM: dt-binding: fix GIC example
In-Reply-To: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
References: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAL_Jsq+_+B=TKMQ2ULkXiBJGTNmGGLkB1xjKNJkF1BK_4TRXkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 11:25 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> From: Tim Harvey <tharvey@gateworks.com>
>
> When using interrupt-maps, the size of a map entry is #address-cells +

Plus what? You mean ", and "?

> address-cells should be 0 as this is not used.
>
> As #address-cells = <0> is the same as not specifying the
> property, simply remove it.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Did this get applied? I can't seem to find patch 2.

Rob
