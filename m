From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 4 Nov 2017 17:34:36 +0800
Subject: [GIT PULL] ARM: actions: dt64 for v4.14
In-Reply-To: <CAOesGMgJH_LEjOr_JAj+J9LRr-dYHy2zS2PAAJM96+hece=HUw@mail.gmail.com>
References: <20170905223252.9478-1-afaerber@suse.de>
 <20170905223252.9478-2-afaerber@suse.de>
 <CAOesGMgJH_LEjOr_JAj+J9LRr-dYHy2zS2PAAJM96+hece=HUw@mail.gmail.com>
Message-ID: <7368054b-8a2f-7f42-08fb-4fb58cd1c725@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Am 16.09.2017 um 05:58 schrieb Olof Johansson:
> On Tue, Sep 5, 2017 at 3:32 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Hi Olof and Arnd,
>>
>> Here's a (late) dt64 pull for Actions Semi.
>> This clock node is needed to make use of the new full serial driver.
>>
>> Regards,
>> Andreas
>>
>> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>>
>>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-dt-for-4.14
>>
>> for you to fetch changes up to f0e12dd55384d5ef53c6e15673d39133dfca5f0a:
>>
>>   arm64: dts: actions: s900-bubblegum-96: Add fake uart5 clock (2017-09-06 00:14:38 +0200)
> 
> Merged into next/late. Thanks!

Hmm, this has still not shown up in linux.git and disappeared in
linux-next.git - did this get lost? Do I need to resubmit this for 4.15?

Same issue with 32-bit dt pull.

Holding back three 4.15 pulls due to this.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
