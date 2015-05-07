From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 May 2015 12:02:33 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150507055231.GB32399@codeaurora.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
Message-ID: <20150507110233.GR15510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 10:52:31PM -0700, Stephen Boyd wrote:

> If you look at the cpufreq/clock/pmic code on our codeaurora.org
> tree you'll see that it's used to pass a value with uA units
> through the regulator_set_optimum_mode() API. The call to
> regulator_set_optimum_mode() is here[1], and the place where we
> parse the OPP table from DT is here[2]. My understanding is that

I'm not looking for anyone to explain this to me in e-mail, what I'm
looking for is for the binding document to be clear so someone can tell
what the binding means by reading the documentation for the binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150507/3f153afb/attachment.sig>
