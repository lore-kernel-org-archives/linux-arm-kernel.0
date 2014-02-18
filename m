From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 18 Feb 2014 12:43:22 +0100
Subject: [PATCH V3 11/17] i2c: nomadik: Convert to devm functions
In-Reply-To: <20140218110109.GA18768@katana>
References: <1392650418-14820-1-git-send-email-ulf.hansson@linaro.org>
 <20140218110109.GA18768@katana>
Message-ID: <CAPDyKFpRaAAer00dqcXR-qOT9S8-SDTnaMUHRwWCZ93w-wnTDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 February 2014 12:01, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Feb 17, 2014 at 04:20:18PM +0100, Ulf Hansson wrote:
>> Use devm_* functions to simplify code and error handling.
>>
>> Cc: Alessandro Rubini <rubini@unipv.it>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> What has changed in V3? I didn't get the cover letter.

I added the IS_ERR, check as you suggested. That caused a rebase of
the other patches as well.

Sorry if it was unclear.

Kind regards
Uffe
