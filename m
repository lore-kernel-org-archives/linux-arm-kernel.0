From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Sep 2014 12:50:46 -0700
Subject: [PATCH 0/2] Add input supplies to rk808 regulator
In-Reply-To: <13302580.b33ghgBegF@diego>
References: <1409674469-12123-1-git-send-email-dianders@chromium.org>
 <13302580.b33ghgBegF@diego>
Message-ID: <CAD=FV=WiB6XnNFz9rPq=DOVU3qOr0yvmpdRN3DK1cKZ+K9hAhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Sep 2, 2014 at 12:48 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag, 2. September 2014, 09:14:27 schrieb Doug Anderson:
>> We want to specify the input supplies to the rk808 regulator.  This
>> patch series adds them to the driver.  Note that the bindings are
>> based atop Chris's most recent version at
>> <https://patchwork.kernel.org/patch/4817931/>.  If the regulator patch
>> is applied before Chris sends out his next version then I think Chris
>> could squash my bindings change (patch 2) into his next version.
>>
>>
>> Doug Anderson (2):
>>   regulator: RK808: Add proper input supplies for rk808
>
> Patch 1 didn't apply, as it didn't take the recent pdata removal Chris
> posted. After fixing this [0], it sucessfully solved the missing supplies
> I've seen on the weekend, so
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks!  ...ah, I guess I usually apply things with "git am -3" and it
didn't complain about applying my patch atop Chris's or not atop
Chris's.  Sorry for not making it clear.
