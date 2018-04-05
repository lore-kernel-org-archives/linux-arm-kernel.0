From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 5 Apr 2018 12:11:39 +0530
Subject: [PATCH v5 1/3] regulator: axp20x: add drivevbus support for axp803
In-Reply-To: <20180327053104.3812-1-jagan@amarulasolutions.com>
References: <20180327053104.3812-1-jagan@amarulasolutions.com>
Message-ID: <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 11:01 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Like axp221, axp223, axp813 the axp803 is also supporting external
> regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>
> Add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes for v5:
> - Collect Chen-Yu reviewed-by tag
> Changes for v4:
> - rebase on master
> Changes for v3:
> - Update drivevbus in table of regulators

Can you pick these, has some dependency with drivevbus on other patches.

Jagan.
