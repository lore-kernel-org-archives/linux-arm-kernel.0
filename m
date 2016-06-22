From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jun 2016 14:04:41 +0200
Subject: [PATCH 1/2] cpufreq: s5pv210: use relaxed IO accesors
In-Reply-To: <20160622093820.GE5458@vireshk-i7>
References: <1466588198-27445-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466588198-27445-2-git-send-email-ben.dooks@codethink.co.uk>
 <20160622093820.GE5458@vireshk-i7>
Message-ID: <CAJKOXPcywVya133jsz5_5mE8j4M3L6+orcWPPrStpNshcj+JsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 11:38 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-06-16, 10:36, Ben Dooks wrote:
>> The use of __raw IO accesors is not endian safe and should be used
>> sparingly. The relaxed variants should be as lightweight and also
>> are endian safe.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: linux-pm at vger.kernel.org
>> Cc: linux-samsung-soc at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>  drivers/cpufreq/s5pv210-cpufreq.c | 68 +++++++++++++++++++--------------------
>>  1 file changed, 34 insertions(+), 34 deletions(-)
>
> For both patches:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied for v4.8, thanks.

When resending the cpufreq-exynos please CC me as well.

Best regards,
Krzysztof
