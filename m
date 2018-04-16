From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 16 Apr 2018 12:34:39 +0800
Subject: [PATCH v5 1/3] regulator: axp20x: add drivevbus support for axp803
In-Reply-To: <20180405064658.rz2grnpm5fq45lhu@flea>
References: <20180327053104.3812-1-jagan@amarulasolutions.com>
 <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com>
 <20180405064658.rz2grnpm5fq45lhu@flea>
Message-ID: <CAGb2v656MCUYiFd2J6ZE5hze2TKQqkMh7hGAUXhjz58qCj58ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 2:46 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Thu, Apr 05, 2018 at 12:11:39PM +0530, Jagan Teki wrote:
>> On Tue, Mar 27, 2018 at 11:01 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>> > Like axp221, axp223, axp813 the axp803 is also supporting external
>> > regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>> >
>> > Add support for it.
>> >
>> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> > ---
>> > Changes for v5:
>> > - Collect Chen-Yu reviewed-by tag
>> > Changes for v4:
>> > - rebase on master
>> > Changes for v3:
>> > - Update drivevbus in table of regulators
>>
>> Can you pick these, has some dependency with drivevbus on other
>> patches.
>
> I'm not the regulator maintainer, nor the AXP maintainer for that
> matter. Mark Brown and Chen-Yu are, respectively.

I've already reviewed all the patches. Please resend the series and
include Mark Brown, the regulator subsystem maintainer. He clearly
isn't in the current recipient list, so no wonder things didn't move
forward. Once he applies the driver bits, we'll apply any pending
device tree changes.

ChenYu
