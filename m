From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 23 Mar 2017 21:40:50 +0100
Subject: [PATCH 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <20170323201719.i5bqrbxr2bejopky@ninjato>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com>
 <20170323201719.i5bqrbxr2bejopky@ninjato>
Message-ID: <CAOAejn383=Zk42nnJoG=qP=uEHpzEwf=5dePx_atyzWGDGBiyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Yes the STM32F7 has a new I2C IP core compared to STM32F4.
The engine, the machine state are very different.
I tried few months ago to write a common driver but it was very very
difficilcut as the 2 IP are not so much things in common.

BR,
Cedric

2017-03-23 21:17 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> On Fri, Mar 17, 2017 at 10:58:56AM +0100, M'boumba Cedric Madianga wrote:
>> This patch adds initial support for the STM32F7 I2C controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>
> So, the STM32F7 has a new I2C IP core compared to STM32F4?
>
