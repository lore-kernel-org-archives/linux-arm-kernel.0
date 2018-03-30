From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 17:38:48 +0800
Subject: [PATCH v3 2/3] arm64: allwinner: axp803: Add drivevbus regulator
In-Reply-To: <1513011400-4120-2-git-send-email-jagan@amarulasolutions.com>
References: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com>
 <1513011400-4120-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAGb2v66m6hKz9OTaBgp9SoyPSXLgqUQDt4=mH8V2XTEzm7OM0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 12:56 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Add reg_drivevbus regualtor for boards which are using
> external regulator to drive the OTG VBus through N_VBUSEN
> PMIC pin.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
