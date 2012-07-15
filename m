From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 15 Jul 2012 13:11:46 +0300
Subject: [PATCH] remoteproc: remove the get_by_name/put API
In-Reply-To: <4FF335E3.5040509@codeaurora.org>
References: <1341259857-17382-1-git-send-email-ohad@wizery.com>
 <4FF335E3.5040509@codeaurora.org>
Message-ID: <CAK=WgbZ7ZoVqniJzfXXvq1krUWanteB73J=28GstnFmpWGHfvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 9:11 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/02/12 13:10, Ohad Ben-Cohen wrote:
>> Remove rproc_get_by_name() and rproc_put(), and the associated
>> remoteproc infrastructure that supports it (i.e. klist and friends),
>> because:
>>
>> 1. No one uses them
>> 2. Using them is highly discouraged, and any potential user
>>    will be deeply scrutinized and encouraged to move.
>>
>> If a user, that absolutely can't live with the direct boot/shutdown
>> model, does show up one day, then bringing this functionality back
>> is going to be trivial.
>>
>> At this point though, keeping this functionality around is way too
>> much of a maintenance burden.
>>
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, applied.
