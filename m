From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 29 Jan 2018 17:56:52 +0100
Subject: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
In-Reply-To: <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
Message-ID: <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-29 17:17 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Tue, Jan 16, 2018 at 05:06:15PM +0100, Peter Rosin wrote:
>> Makes them easier to find.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This one should go into 4.16. I can apply after rc1 or apply to tree
> with at24.txt changes queued.
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> Rob

Wolfram,

can you take this via the i2c tree for 4.16?

Thanks,
Bartosz
