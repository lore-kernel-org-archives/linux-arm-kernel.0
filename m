From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 13 Sep 2012 14:11:11 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva: Add support RTC
In-Reply-To: <20120913040629.GA23861@verge.net.au>
References: <1347505841-8594-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <20120913040629.GA23861@verge.net.au>
Message-ID: <CABMQnV+qmmP412W1Cd3mOpJynDfgiuzot=fw4O+bYMYOBKRnVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 13, 2012 at 1:06 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Sep 13, 2012 at 12:10:41PM +0900, Nobuhiro Iwamatsu wrote:
>> The armadillo800eva has S35390A which is RTC. This is controlled
>> using I2C of GPIO.
>> This commit supports RTC of armadillo800eva.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>
> Hi Iwamatsu-san,
>
> could you please either update this patch or provide a follow-up
> patch to update the defconfig so the S35390A is enabled?
>
> "make savedefconfig" may be useful for this.

OK, I will resend with updated defconfig.

-- 
Nobuhiro Iwamatsu
