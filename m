From: jeffy.chen@rock-chips.com (jeffy)
Date: Tue, 19 Sep 2017 20:44:35 +0800
Subject: [RESEND PATCH v2 3/3] ASoC: rockchip: Init dapm routes dynamically
In-Reply-To: <20170919122803.kybaln43yho3deih@sirena.co.uk>
References: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
 <20170918111801.12881-3-jeffy.chen@rock-chips.com>
 <20170919122803.kybaln43yho3deih@sirena.co.uk>
Message-ID: <59C11133.5090400@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/19/2017 08:28 PM, Mark Brown wrote:
> On Mon, Sep 18, 2017 at 07:18:01PM +0800, Jeffy Chen wrote:
>> Currently we are using a fixed list of dapm routes.
>>
>> Init dapm routes dynamically when parsing dailinks, since we are
>> supporting optional codecs.
>
> This doesn't apply against current code, please check and resend.
>

i rebased these patches to for-next 20170919, but nothing changed...


but i found my other pending patch 
(https://patchwork.kernel.org/patch/9958055) might conflict to this, 
i'll send a new series to put all my patches together and solve the 
conflict...

sorry for the trouble..
