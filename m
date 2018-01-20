From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 20 Jan 2018 14:55:01 +0800
Subject: [PATCH v4 1/3] regulator: axp20x: add drivevbus support for axp803
In-Reply-To: <1515738618-3617-1-git-send-email-jagan@amarulasolutions.com>
References: <1515738618-3617-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAGb2v66no9YijT=4e-2X3X62sZ-YDCgFXaZ_ruamFS8Myr8+xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 2:30 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Like axp221, axp223, axp813 the axp803 is also supporting external
> regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>
> Add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
