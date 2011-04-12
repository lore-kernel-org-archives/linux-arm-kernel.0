From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Apr 2011 10:53:23 -0600
Subject: [PATCH 1/2] ux500: Adding support for u8500 Hsem functionality V2
In-Reply-To: <BANLkTin7DEWJt4PrBp85disqXd9ZBG3Z_g@mail.gmail.com>
References: <1302535464-12294-1-git-send-email-mathieu.poirier@linaro.org>
	<BANLkTin7DEWJt4PrBp85disqXd9ZBG3Z_g@mail.gmail.com>
Message-ID: <4DA48383.4000604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-04-12 07:44 AM, Ohad Ben-Cohen wrote:
> On Mon, Apr 11, 2011 at 6:24 PM,<mathieu.poirier@linaro.org>  wrote:
>> From: Mathieu J. Poirier<mathieu.poirier@linaro.org>
>>
>> This is the second spin on STE's Hsem driver that is implemented
>> through the hwspinlock scheme.  More specifically:
>>
>>   More comments have been added in the code.
>>   Cleanup of included header files.
>>   One of the original contributor's name corrected.
>>   Calls to 'pm_runtime_disable'restored.
>>
>> Signed-off-by: Mathieu Poirier<mathieu.poirier@linaro.org>
>> ---
> Looks good, but please revise the commit log (think of a random reader
> who tries to understand what does this patch do, and is less
> interested to hear about its revisions' history).
>
> Otherwise,
>
> Acked-by: Ohad Ben-Cohen<ohad@wizery.com>
>
> (btw I assume the "PATCH 1/2" in the subject is just a typo, and
> there's no missing "PATCH 2/2")
>
Ohad,

I will revise the commit log and send a V3.  The PATCH 1/2 was generated 
by send-email even if there was only one patch file...  But you are 
correct, there was only just one patch.

Mathieu.
