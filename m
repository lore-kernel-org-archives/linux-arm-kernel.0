From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 7 Aug 2013 16:02:16 +0530
Subject: [PATCH V3 1/7] ARM: dts: Change i2s compatible string on
 exynos5250
In-Reply-To: <20130807101057.GY6427@sirena.org.uk>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
 <1375866616-5541-2-git-send-email-padma.v@samsung.com>
 <20130807101057.GY6427@sirena.org.uk>
Message-ID: <CAAgF-Bcezj+QGm78Xpm2ahnMrZMqpcnLJaB5bbFyxJDGMTMrpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Aug 7, 2013 at 3:40 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 07, 2013 at 02:40:10PM +0530, Padmavathi Venna wrote:
>> This patch removes quirks from i2s node and change the i2s
>> compatible names.
>
> This needs to go along with the driver change otherwise we break
> bisection.

some of the patches at dts side are dependent on this patch. So I
separated it into another set. Should I re-post this patch along with
other driver side patches?

Thanks
Padma
