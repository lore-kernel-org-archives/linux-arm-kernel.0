From: kgene.kim@gmail.com (Kukjin Kim)
Date: Tue, 23 Apr 2013 23:33:38 +0900
Subject: [PATCH v5 3/6] gpio: samsung: Skip legacy GPIO registration if
 pinctrl-s3c64xx is present
In-Reply-To: <20130417130609.GA13687@opensource.wolfsonmicro.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-4-git-send-email-tomasz.figa@gmail.com>
 <20130416162750.GO26958@opensource.wolfsonmicro.com>
 <22399020.Z89v9QS8su@flatron>
 <20130417130609.GA13687@opensource.wolfsonmicro.com>
Message-ID: <51769BC2.9010507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/13 22:06, Mark Brown wrote:
> On Wed, Apr 17, 2013 at 12:35:58AM +0200, Tomasz Figa wrote:
>> On Tuesday 16 of April 2013 17:27:50 Mark Brown wrote:
>
>>> Strictly speaking this is a separate bug fix (though I see that's
>>> already in -next separately anyway so whatever).
>
I agree with this.

>> Right. But this fix is so small that I thought it would be a major waste
>> of mail server processing power to send it as a separate patch.
>
But the fix would be value...

> There's reviewer bandwidth too - one of the things people check for is
> that the change is doing what it's supposed to do, extra stuff in there
> is usually a red flag.

Thanks.

- Kukjin
