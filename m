From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 29 Feb 2012 22:44:55 +0100
Subject: atmel-mci causing oops?
In-Reply-To: <m2linlo83r.fsf@bob.laptop.org>
References: <20120229173115.GA23529@ldesroches-Latitude-E6320>
 <m2linlo83r.fsf@bob.laptop.org>
Message-ID: <4F4E9C57.9020502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On 02/29/2012 06:35 PM, Chris Ball wrote:
> Hi Ludovic,
>
> On Wed, Feb 29 2012, Ludovic Desroches wrote:
>> You can find the two patches into the mmc-next tree of Chris:
>> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=43df92914ea0623893bcb801791d5d2be2f5e015
>> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=9cfa4030ea90f2fc204532975a824b987433f6dd
>>
>> By the way, Chris, is it possible to put these patches as a fix for 3.3
>> kernel? Without them we will have this oops each time someone would use
>> mmc without a DMA Controller or if it is impossible to get a dma channel.
> Will do, thanks.  Should they go to 3.2-stable, too?
>
> - Chris.
You're right 3.2 kernel is also concerned so they can go to 3.2-stable.

Thanks.

Ludovic
