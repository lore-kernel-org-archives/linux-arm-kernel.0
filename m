From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 2 May 2016 19:03:41 +0100
Subject: [PATCH v2 2/2] nvmem: mxs-ocotp: remove nvmem regmap dependency
In-Reply-To: <CAOMZO5DoqdOPM+i6D37PviCbiDSc3OV2rz8vGRi0mqV4uBvgaw@mail.gmail.com>
References: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1462202578-15433-3-git-send-email-srinivas.kandagatla@linaro.org>
 <CAOMZO5DoqdOPM+i6D37PviCbiDSc3OV2rz8vGRi0mqV4uBvgaw@mail.gmail.com>
Message-ID: <5727967D.8030202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/05/16 17:15, Fabio Estevam wrote:
> On Mon, May 2, 2016 at 12:22 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> This patch moves to nvmem support in the driver to use callback
>> instead of regmap.
>
> It would be nice if you could explain the reason for doing this.
>

Sure, Basically using regmap raw accessors in a generic way in nvmem 
core broken nvmem providers based on regmap mmio bus.

More details at 
https://groups.google.com/forum/#!topic/linux.kernel/LT3hM-GOf1k

thanks,
srini
