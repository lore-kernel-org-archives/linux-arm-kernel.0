From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 7 May 2013 22:26:07 +0530
Subject: [PATCHv2 3/4] mailbox: pl320: Introduce common API driver
In-Reply-To: <51885FC4.7000401@gmail.com>
References: <1367824946-6160-1-git-send-email-jaswinder.singh@linaro.org>
 <1367825063-6263-1-git-send-email-jaswinder.singh@linaro.org>
 <51885FC4.7000401@gmail.com>
Message-ID: <CAJe_ZheEut1fbifGeWfiZmar0zm_ZgdzygeaAYTOitSR_tqbiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2013 07:28, Rob Herring <robherring2@gmail.com> wrote:
> On 05/06/2013 02:24 AM, Jassi Brar wrote:
>> Convert the PL320 controller driver to work with the common
>> mailbox API. Also convert the only user of PL320, highbank-cpufreq.c
>> to work with thee API. Drop the obsoleted driver pl320-ipc.c
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> ---
>>  drivers/cpufreq/highbank-cpufreq.c |   22 +++-
>>  drivers/mailbox/Makefile           |    2 +-
>>  drivers/mailbox/pl320-ipc.c        |  198 ---------------------------------
>>  drivers/mailbox/pl320.c            |  212 ++++++++++++++++++++++++++++++++++++
>
> Can you resend this using git format-patch -M option.
>
IIRC I already did that. Anyways I just checked -M doesn't produce
anything different for the patch. Except for headers, defines and
module init rituals, everything else is from scratch.

-Jassi
