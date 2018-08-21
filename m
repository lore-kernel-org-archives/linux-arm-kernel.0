From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Aug 2018 15:33:22 +0100
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
In-Reply-To: <20180821162644.5a1d7799@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <20180821005327.0d312a85@tock> <20180821074404.23aaeb6b@bbrezillon>
 <20180821142716.0adcdd56@eos> <20180821145725.3b385399@bbrezillon>
 <20180821155706.2adf3b4c@eos> <20180821162644.5a1d7799@bbrezillon>
Message-ID: <2d5761f4-2c27-5a23-a635-9205124c993a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/08/18 15:26, Boris Brezillon wrote:
>> This also has the side effect that nvmem cells defined in DT don't
>> appear in sysfs, unlike those defined from board code.
> Wow, that's not good. I guess we'll want to make that consistent at
> some point.
> 
support for sysfs entries per cell is not available in nvmem. However 
there is nvmem sysfs entry per provider which can be read by the user 
space if required.


--srini
