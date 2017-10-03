From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Oct 2017 17:01:52 +0800
Subject: [PATCH v3 04/12] pinctrl: axp209: add programmable
 gpio_status_offset
In-Reply-To: <20171002203831.rvf7g7nzg2wacrve@flea>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-5-quentin.schulz@free-electrons.com>
 <20171002203831.rvf7g7nzg2wacrve@flea>
Message-ID: <CAGb2v67JkMOcBzAwKwDxsiJpNZ-vibp7=Kj7YOMWhvWLFnn9ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 4:38 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Oct 02, 2017 at 12:08:46PM +0000, Quentin Schulz wrote:
>> To prepare for patches that will add support for a new PMIC that has a
>> different GPIO input status register, add a gpio_status_offset within
>> axp20x_pctl structure and use it.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
