From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 15 Dec 2013 22:14:02 -0800
Subject: [PATCH v2 2/3] clk: bcm281xx: add initial clock framework support
In-Reply-To: <52AE81B3.4010203@linaro.org>
References: <529F4B0F.2020801@linaro.org> <529F4B4F.4020405@linaro.org>
 <20131214235731.26321.53050@quantum> <52ADE93B.3070907@linaro.org>
 <E566434B-F630-4AD3-91EC-BD5599767F2E@linaro.org>
 <52AE81B3.4010203@linaro.org>
Message-ID: <CAPtuhTi08LO7XfZa=7xArA2m2989FkTo4v+WRH+d_JmeKhvjuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 15, 2013 at 8:29 PM, Alex Elder <alex.elder@linaro.org> wrote:
> In the mean time, I have created a new branch that
> is based on v3.13-rc4 (and includes Tim's prerequisite
> patches).  Pull request (still wrapped my my mailer)
> is below.

Hi Alex,

This isn't a mess but is pretty normal. Can you create a new branch
with only your 2 clock patches applied on top of my clk-next branch?
You should merge "ARM: dts: bcm281xx: define real clocks" through the
arm-soc tree. Then you can send another pull request to me which has
just the 2 bcm clock patches based on clk-next and everything will
eventually end up linux-next all together.

Just FYI if I took your pull request as-is then the clk-next tree
would become polluted with lots of extra bcm patches.

Regards,
Mike
