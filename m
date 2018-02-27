From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 27 Feb 2018 08:06:18 +0100
Subject: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
In-Reply-To: <CAJKOXPczu67vPQEzQZvFRZGVNBpk0U6GJhSnb4dYWSgTY+Unog@mail.gmail.com>
References: <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
 <20180221085541.14556-1-a.hajda@samsung.com>
 <20180221085541.14556-5-a.hajda@samsung.com>
 <CAJKOXPczu67vPQEzQZvFRZGVNBpk0U6GJhSnb4dYWSgTY+Unog@mail.gmail.com>
Message-ID: <513ee866-a44e-5969-4584-0385029e0356@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.02.2018 16:21, Krzysztof Kozlowski wrote:
> On Wed, Feb 21, 2018 at 9:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> OF graph describes MHL data lanes between MHL and respective USB
>> connector.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v4:
>> - added missing reg property in connector's port node (Krzysztof)
>> ---
>>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 3 deletions(-)
> You have a duplicated '};' so kbuild complains so I assume there will
> be next iteration of this. Beside that I am okay with both, so I will
> take next version when your bindings and driver changes get
> acked/accepted.

Yes, test robot already reported it, thanks for looking at it.
I have postponed next iteration in case anything new is spotted, but
since it is calm I will send it in few minutes.

Regards
Andrzej

>
> Best Regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
