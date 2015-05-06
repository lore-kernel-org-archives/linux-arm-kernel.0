From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 6 May 2015 12:23:19 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150505171252.GI22845@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
Message-ID: <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 22:42, Mark Brown <broonie@kernel.org> wrote:
> This still doesn't say what the value is supposed to mean which means
> it's not possible for someone to write generic code which handles the
> binding - saying that people can reference the value doesn't tell them
> how to interpret it.  A limit?  A nominal constant draw value?  A value
> to regulate to?  Those are all different things expressed as a current.

@Stephen: Can you please answer these queries please, so that we
can get the bindings correctly ?
