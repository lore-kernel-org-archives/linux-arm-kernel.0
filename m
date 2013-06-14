From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 14 Jun 2013 17:07:48 +0200
Subject: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
In-Reply-To: <20130614140719.GC2929@katana>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130614140719.GC2929@katana>
Message-ID: <51BB31C4.2090302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/13 16:07, Wolfram Sang wrote:
> On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
>> This patchset adds support for the I2C controller found on most of the
>> Allwinner SoCs, especially the already supported A10 and A13, and the
>> yet to come A31.
>>
>> This driver leverages the Marvel mv64xxx i2c controller driver, that has
>> an almost identical logic, with a slightly different register layout.
>
> \o/ Yay, that's more like it. Thanks for the rework!
>
>> It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
>
> I'd love to get some Tested-by or other tags for Marvell hardware. Any
> volunteers?

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

on Marvell Dove, v3.10-rc5 with i2c/for-next merged in.

Sebastian
