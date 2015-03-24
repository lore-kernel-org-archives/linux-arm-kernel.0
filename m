From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 24 Mar 2015 23:07:23 +0000
Subject: [PATCH v3 2/9] regmap: Introduce regmap_get_reg_stride.
In-Reply-To: <20150324223745.GC28997@sirena.org.uk>
References: <1427236116-18531-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427236200-18625-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150324223745.GC28997@sirena.org.uk>
Message-ID: <5511EE2B.4040109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/03/15 22:37, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 10:30:00PM +0000, Srinivas Kandagatla wrote:
>
>> + /* regmap_get_reg_stride(): Report the register address stride
>> + *
>> + * Report the register address stride, mainly intended to for use by
>> + * generic infrastructure built on top of regmap.
>> + */
>> +int regmap_get_reg_stride(struct regmap *map)
>
> Please fix the indentation for the comment block and add kerneldoc for
> the argument.  This is an exported function so it should also be /** not
> /*
>
My bad.. I will fix it in next version.
