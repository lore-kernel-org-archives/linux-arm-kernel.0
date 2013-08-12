From: zonque@gmail.com (Daniel Mack)
Date: Mon, 12 Aug 2013 11:17:21 +0200
Subject: [alsa-devel] [PATCH 5/5] ASoC: pxa: add DT bindings for pxa2xx-pcm
In-Reply-To: <5208A424.70704@metafoo.de>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-6-git-send-email-zonque@gmail.com>
 <5208A424.70704@metafoo.de>
Message-ID: <5208A821.6060604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.08.2013 11:00, Lars-Peter Clausen wrote:
> On 08/12/2013 10:42 AM, Daniel Mack wrote:
>> The bindings do not carry any resources, as the module only registers
>> the ASoC platform driver.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> As this is just a virtual device (and Linux specific) it shouldn't be in the 
> devicetree. Usually when using devicetree you'd register the PCM device from 
> the CPU DAI driver. Take a look at how other platforms (e.g. tegra) do this.

Ok, then please ignore this one for now.


Thanks,
Daniel
