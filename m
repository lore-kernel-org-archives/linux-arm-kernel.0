From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 20 Jan 2018 14:55:30 +0800
Subject: [PATCH v4 2/3] arm64: allwinner: axp803: Add drivevbus regulator
In-Reply-To: <1515738618-3617-2-git-send-email-jagan@amarulasolutions.com>
References: <1515738618-3617-1-git-send-email-jagan@amarulasolutions.com>
 <1515738618-3617-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAGb2v65sO3NLBnfXT_zFzUtD5-C0EyWPBptgrf4==2SNMTm57g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 2:30 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Add reg_drivevbus regualtor for boards which are using
> external regulator to drive the OTG VBus through N_VBUSEN
> PMIC pin.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
