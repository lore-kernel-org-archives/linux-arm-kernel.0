From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Oct 2017 23:12:35 +0800
Subject: [PATCH v2 1/8] mfd: axp20x: Add axp20x-regulator cell for AXP813
In-Reply-To: <20171031150737.7enqmjooo5nayzvb@dell>
References: <20171018083138.14517-1-wens@csie.org>
 <20171018083138.14517-2-wens@csie.org>
 <20171031133614.bcj4k3phh4q5qxes@flea> <20171031150737.7enqmjooo5nayzvb@dell>
Message-ID: <CAGb2v679wywznY-H5-bs3r8nz50yWPMe3hH_2CV48fBr+-iw_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 11:07 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 31 Oct 2017, Maxime Ripard wrote:
>> On Wed, Oct 18, 2017 at 04:31:31PM +0800, Chen-Yu Tsai wrote:
>> > Now that axp20x-regulator supports AXP813, we can add a cell for it
>> > to enable it.
>> >
>> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> > Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>
>> Is there any chance this gets merged for 4.15?
>
> Can it go in by itself?

Yes. There are no build time dependencies. And the regulator driver changes
are already in the regulator tree.

ChenYu
