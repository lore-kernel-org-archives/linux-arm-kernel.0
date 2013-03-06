From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 6 Mar 2013 17:22:11 +0530
Subject: [PATCH] ASoC: samsung: let device core setup the default pin
 configuration
In-Reply-To: <20130306114918.GB19556@opensource.wolfsonmicro.com>
References: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
 <20130306113741.GA19556@opensource.wolfsonmicro.com>
 <201303061242.09978.heiko@sntech.de>
 <20130306114918.GB19556@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwS29ToJ+-1S4G+K=3W1C1TRxLcfPrE=rC_OE4fHyWSc5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2013 17:19, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 06, 2013 at 12:42:09PM +0100, Heiko St?bner wrote:
>
>> What is going away is the deprecated non-pinctrl way to setup the pins on dt
>> platforms.
>
> OK, can we have a changelog improvement please?  I didn't read the patch
> properly because the changelog said it would break my primary
> development system.

Ok. I will repost again with additional details in the changelog.
