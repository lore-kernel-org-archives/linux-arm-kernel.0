From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Feb 2018 17:18:52 +0800
Subject: [PATCH 04/10] ARM: dts: sun[4-7]i: Remove
 "cooling-{min|max}-level" for CPU nodes
In-Reply-To: <20180213091333.rq4rtvvkwppn5ypu@flea.lan>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <4d489d040ec1fc3821d8e4bf31ffcc2eebfa41e1.1518166039.git.viresh.kumar@linaro.org>
 <20180213091333.rq4rtvvkwppn5ypu@flea.lan>
Message-ID: <CAGb2v65Rq5UY_=Fspb_j79a36SK_f+dd2Yb2zAqfg7riiaEO7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 5:13 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Fri, Feb 09, 2018 at 02:28:04PM +0530, Viresh Kumar wrote:
>> The "cooling-min-level" and "cooling-max-level" properties are not
>> parsed by any part of the kernel currently and the max cooling state of
>> a CPU cooling device is found by referring to the cpufreq table instead.

That doesn't mean that other systems aren't using it. It's still part of
the device tree binding. Last I checked, while they are optional, they
aren't deprecated.

Any comments from the device tree maintainers?

>>
>> Remove the unused properties from the CPU nodes.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Applied, thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com
