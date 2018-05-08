From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 8 May 2018 10:11:07 -0700
Subject: [PATCH v9 00/12] Sunxi: Add SMP support on A83T
In-Reply-To: <20180508131914.6sy7cd6urnfg3tam@flea>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180508131914.6sy7cd6urnfg3tam@flea>
Message-ID: <7491f58f-d24d-8f7c-c195-87d13457fd80@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2018 06:19 AM, Maxime Ripard wrote:
> Hi,
> 
> On Fri, May 04, 2018 at 09:05:33PM +0200, Myl?ne Josserand wrote:
>> Hello everyone,
>>
>> This is a V9 of my series that adds SMP support for Allwinner sun8i-a83t.
>> Based on sunxi's tree, sunxi/for-next branch.
>> Depends on a patch from Doug Berger that allows to include the "cpu-type"
>> header on assembly files that I included in my series (patch 01).
> 
> I applied the patches, with the remarks done by Russell on v8 fixed,
> and the function sun8i_a83t_cntvoff_init made static.

Did you push those patches to sunxi/linux.git yet? I would like to make
sure I have the same copy of patch 1 since that is necessary for some of
our Broadcom ARM SoCs for 4.18.

Thanks!
-- 
Florian
