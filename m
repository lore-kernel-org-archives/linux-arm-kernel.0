From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 10 Jul 2012 19:14:53 +0530
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <20120710134436.GD9409@opensource.wolfsonmicro.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
 <4FE882A5.3080504@nvidia.com>
 <20120625222646.GB30406@opensource.wolfsonmicro.com>
 <4FE8EFC4.3090509@wwwdotorg.org> <4FFC190A.2040800@nvidia.com>
 <20120710134436.GD9409@opensource.wolfsonmicro.com>
Message-ID: <4FFC31D5.7090600@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 July 2012 07:14 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Tue, Jul 10, 2012 at 05:29:06PM +0530, Laxman Dewangan wrote:
>
>> Looked tps6586x-regulator driver and it has the platform data which
>> is regulator_init_data.
>> So for adding the vin-supply similar to what we have in fixed or
>> tps6591x regulator to pass through the desc.supply_name, we are not
>> having option here in platform data which can work for DT and non-DT
>> case.
>> So if still want to have the DT and non-DT case similar, we can add
>> one tps6586x_regulator_platform_data as
> The supply names are not supposed to be conditional (I realise they are
> for your current DT patch, I let that in because I just want to see an
> end to all this DT stuff).
>

Sorry, I did not get it fully. I had two patches, one for fixed one and 
other for tps65910. On which patch, you are seeing issue and which part 
of code?
I like to fix it if it does not conform the DT or your expectation or 
any future enhancement which you are planning.
Little bit more details will help so that I will not repeat the same and 
fix it in my future patches.

Thanks,
Laxman
