From: jeffy.chen@rock-chips.com (jeffy)
Date: Tue, 22 Aug 2017 17:25:05 +0800
Subject: [PATCH v5 6/9] ASoC: rockchip: Parse dai links from dts
In-Reply-To: <CAErzpmsfgW47ezbUUVkqhdrca8Bwti3MMXWkBJDu_YDcow0vHw@mail.gmail.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-7-jeffy.chen@rock-chips.com>
 <CAErzpmsfgW47ezbUUVkqhdrca8Bwti3MMXWkBJDu_YDcow0vHw@mail.gmail.com>
Message-ID: <599BF871.8000408@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Donglin,

On 08/22/2017 05:08 PM, Donglin Peng wrote:
>> >         card->dev = &pdev->dev;
>> >         platform_set_drvdata(pdev, card);
> There is no need to call platform_set_drvdata, because
> devm_snd_soc_register_card will do it.
>

right, will remove it in next version, thanks:)
