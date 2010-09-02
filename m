From: ccross@google.com (Colin Cross)
Date: Thu, 2 Sep 2010 15:07:46 -0700
Subject: [PATCH] [ARM] tegra: Add i2c support
In-Reply-To: <4C52C766.7040709@ti.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
	<4C52C766.7040709@ti.com>
Message-ID: <AANLkTikxPMY-5Kf2oSAmpZhMjoT6gd_FuiGnWpgR=mpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 5:36 AM, Anand Gadiyar <gadiyar@ti.com> wrote:
> On 07/30/2010 06:06 AM, Colin Cross wrote:
>>
>> +/* i2c_writel and i2c_readl will offset the register if necessary to talk
>> + * to the I2C block inside the DVC block
>> + */
>
> Minor coding-style comment. Documentation/CodingStyle says the preferred
> format for multi-line comments is to do:
>
> /*
> ?* i2c_writel and i2c_readl ...
> ?* to the I2C block ...
> ?*/
Done
