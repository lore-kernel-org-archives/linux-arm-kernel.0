From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 5 Jul 2011 23:31:53 +0200
Subject: [PATCH v3] mmc: documentation of mmc non-blocking request usage
	and design.
In-Reply-To: <20110705132706.f610abb0.rdunlap@xenotime.net>
References: <1309895008-2587-1-git-send-email-per.forlin@linaro.org>
	<1309895008-2587-2-git-send-email-per.forlin@linaro.org>
	<20110705132706.f610abb0.rdunlap@xenotime.net>
Message-ID: <CAJ0pr18MS-zA8xcjE90YQPaG1aUGJZAh_ZFAzhpguPSF-f5sKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 July 2011 22:27, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Tue, ?5 Jul 2011 21:43:28 +0200 Per Forlin wrote:
>
>> Documentation about the background and the design of mmc non-blocking.
>> Host driver guidelines to minimize request preparation overhead.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>
> It would be better to omit the introductory email and put all of its comments
> in this one [PATCH] email.
>
I agree. I'll put the changelog after "--" to exclude it from the
commit message.
All of your comments will be updated in v4.

Thanks for your comments,
Per
