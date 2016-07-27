From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 27 Jul 2016 09:06:05 -0600
Subject: [PATCH 00/14] PM: SoC idle support using PM domains
In-Reply-To: <m260rsuk5q.fsf@baylibre.com>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <m260rsuk5q.fsf@baylibre.com>
Message-ID: <20160727150605.GE1369@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26 2016 at 16:08 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Hi all,
>>
>> Changes since RFC-v3:
>> - Reorganize the patches. Documentations have their own patch.
>> - Moved code around with PSCI OS initiated so they would not have compiler
>>   errors in other configuration.
>> - Minor bug fixes with genpd power_on functionality.
>> - Rebased on top of 4.7-rc1
>
>This is looking good.  I've had a quick look through this, as well as
>tested it on apq8016-sbc (dragon 410c.)
>
Thanks Kevin.


>Seems the main thing left to resolve is the DT description.
>
I am inclining to have the DT description point to arm,idle-state as
suggested by Mark. I will change this in my next revision.

Thanks for your time.

Lina
