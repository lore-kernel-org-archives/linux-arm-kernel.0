From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 29 Sep 2017 20:44:23 +0200
Subject: next-20170926 build: 2 failures 1 warnings (next-20170926)
In-Reply-To: <20170928190020.yyntjpmh5jebydsa@sirena.org.uk>
References: <E1dwn6w-0002eY-VE@optimist>
 <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
 <20170928190020.yyntjpmh5jebydsa@sirena.org.uk>
Message-ID: <CAPDyKFoVaYoMVv4C+6prgZfHgAD8gMBGJTMzzNP24czyj_goww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Stephen

On 28 September 2017 at 21:00, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 26, 2017 at 09:11:00AM -0700, Mark Brown wrote:
>> On Tue, Sep 26, 2017 at 11:29:06AM +0100, Build bot for Mark Brown wrote:
>>
>> Today's -next fails to build an arm and arm64 allmodconfig with:
>>
>> >     arm64-allmodconfig
>> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
>> >
>> >     arm-allmodconfig
>> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
>>
>> caused by d8034e3379a83 (mmc: sdhci-msm: Utilize bulk clock API).
>
> This is still present in today's -next.

There is a fix for this, Stephen told me off list that is going to
pick it up and send it for rcs.

https://patchwork.kernel.org/patch/9967381/

If the error remains, I will drop the changes causing it.

Kind regard
Uffe
