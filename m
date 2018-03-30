From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 17:39:06 +0800
Subject: [PATCH v3 1/3] regulator: axp20x: add drivevbus support for axp803
In-Reply-To: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com>
References: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAGb2v66xYHHXWkLdovXVsQNPfsJSgZReTUYp_UH=LOk9_MXMCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 12:56 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Like axp221, axp223, axp813 the axp803 is also supporting external
> regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>
> Add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
