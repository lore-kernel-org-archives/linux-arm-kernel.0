From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 14 Sep 2018 09:58:28 +0100
Subject: [PATCH v2 11/11] arm: dts: ste-dbx5x0: Update coresight bindings
 for hardware port
In-Reply-To: <CACRpkdanfg5s6_cAHdr3Sgc1NodNk+ECK8w0DoLvMvw9dxuWwA@mail.gmail.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-12-suzuki.poulose@arm.com>
 <CACRpkdanfg5s6_cAHdr3Sgc1NodNk+ECK8w0DoLvMvw9dxuWwA@mail.gmail.com>
Message-ID: <3e037edf-022b-84c0-93c4-cc0543b4c1eb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 14/09/18 09:43, Linus Walleij wrote:
> On Wed, Sep 12, 2018 at 3:54 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
>> Switch to the new coresight bindings
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 

Thanks.

> I guess you will merge this with the rest of the patches so I do
> not need to queue it?

We haven't figured out that yet. I guess it would be ideal if we
could merge this via arm-soc ? To avoid possible conflict with
other changes to the dts in the series. Sudeep has queued the
TC2 and Juno changes. So, if you could queue it, that is fine
with us.

Suzuki
