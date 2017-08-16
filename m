From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 21:33:56 +0200
Subject: [PATCH] soc: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqLYz9ACd-YAtU0gEHkY8A++cCeBTW9jvUyc5OheEq4scQ@mail.gmail.com>
References: <20170718214339.7774-49-robh@kernel.org>
 <CAL_JsqLYz9ACd-YAtU0gEHkY8A++cCeBTW9jvUyc5OheEq4scQ@mail.gmail.com>
Message-ID: <CAK8P3a3eEV8KWb-cCovRH0LQQ+88yJ7R9se1sjd06K_TyPzKjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:09 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jul 18, 2017 at 4:43 PM, Rob Herring <robh@kernel.org> wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Scott Wood <oss@buserror.net>
>> Cc: Qiang Zhao <qiang.zhao@nxp.com>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>

> Arnd, Olof,
>
> Can you please apply this one.

Applied to next/drivers with the various Acks, thanks!

      Arnd
