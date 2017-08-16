From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 17:22:18 +0200
Subject: [PATCH] bus: Convert to using %pOF instead of full_name
In-Reply-To: <20170719062200.aixn34tcmxy3h6dl@flea>
References: <20170718214339.7774-11-robh@kernel.org>
 <20170719062200.aixn34tcmxy3h6dl@flea>
Message-ID: <CAK8P3a3FtaPn-MnE+1e29cr_vwUaQWBoUv6=x6+AZ04HcncX_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 8:22 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jul 18, 2017 at 04:42:51PM -0500, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>  drivers/bus/arm-cci.c   | 12 ++++++------
>>  drivers/bus/imx-weim.c  |  8 ++++----
>>  drivers/bus/sunxi-rsb.c | 22 +++++++++++-----------
>
> for sunxi-rsb:
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>

Applied to next/drivers, thanks!

       Arnd
