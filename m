From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 17:12:55 -0500
Subject: [PATCH] pwm: Convert to using %pOF instead of full_name
In-Reply-To: <20170725113854.GA22355@ulmo>
References: <20170718214339.7774-45-robh@kernel.org>
 <20170725113854.GA22355@ulmo>
Message-ID: <CAL_Jsq+Oumkr=Npktxz2RnC9EMf8QWgvaw8SKx1uCLbjQg==Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 6:38 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Jul 18, 2017 at 04:43:25PM -0500, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Carlo Caione <carlo@caione.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: linux-pwm at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-amlogic at lists.infradead.org
>> ---
>>  drivers/pwm/pwm-meson.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Applied, thanks.

This is not showing up in -next.

Rob
