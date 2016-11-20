From: nicolae.rosia.oss@gmail.com (Nicolae Rosia)
Date: Sun, 20 Nov 2016 14:57:24 +0200
Subject: [PATCH] mfd: twl-core: make driver DT only
In-Reply-To: <20161118190115.GB23246@dell.home>
References: <1478952153-26592-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118190115.GB23246@dell.home>
Message-ID: <CAKP5S=1R0otWP_YFRn-jL8Q0HhPLhqy1YeF2m0CxFdbHLQGUng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 18, 2016 at 9:01 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 12 Nov 2016, Nicolae Rosia wrote:
>
>> All users are DT-only and it makes no sense to keep
>> unused code
>>
>> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
>> ---
>>  drivers/mfd/Kconfig    |   1 +
>>  drivers/mfd/twl-core.c | 395 ++-----------------------------------------------
>>  2 files changed, 10 insertions(+), 386 deletions(-)
>
> I think it would be courteous to add some of the serious contributors
> to the review list.
>
> There may still be some out of tree users who might wish for a
> heads-up that this change is about to be merged.
Thanks, sure, I will do that in v2.
