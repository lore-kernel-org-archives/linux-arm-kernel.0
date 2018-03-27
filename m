From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 14:29:48 +0200
Subject: [PATCH 06/10] ARM64: dts: meson: Remove "cooling-{min|max}-level"
 for CPU nodes
In-Reply-To: <20180320013731.olxjil4qfj6ppjsl@vireshk-mac-ubuntu>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
 <20180320013731.olxjil4qfj6ppjsl@vireshk-mac-ubuntu>
Message-ID: <CAK8P3a2CvoXxbDAopT7Gt5eHx-0bKabP8dYc8_ObtDrd6Q2Tuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 2:37 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 09-02-18, 14:28, Viresh Kumar wrote:
>> The "cooling-min-level" and "cooling-max-level" properties are not
>> parsed by any part of the kernel currently and the max cooling state of
>> a CPU cooling device is found by referring to the cpufreq table instead.
>>
>> Remove the unused properties from the CPU nodes.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
>>  1 file changed, 4 deletions(-)
>
> @Arnd: Can you please pick this and patch 8/10 from this series for 4.17 ? Both
> are already Acked by Neil. I have just re-bounced both the messages to
> arm at kernel.org. Thanks.

Picked up patches 6, 7 and 8 now. For some reason I didn't see patch 8
in my arm at kernel.org inbox, but I found it on the mailing list.

       Arnd
