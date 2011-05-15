From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 15 May 2011 10:25:05 +0300
Subject: [PATCH 1/2] Initial B&N Nook Color (encore) support.
In-Reply-To: <8D96E746-8C8F-44B1-9AFE-8A71F8AF082D@linuxhacker.ru>
References: <1304891407-29364-1-git-send-email-green@linuxhacker.ru>
	<1304891407-29364-2-git-send-email-green@linuxhacker.ru>
	<4DC791C9.9040709@compulab.co.il>
	<8D96E746-8C8F-44B1-9AFE-8A71F8AF082D@linuxhacker.ru>
Message-ID: <4DCF7FD1.6090209@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/11 06:52, Oleg Drokin wrote:

> Hello!
>
> On May 9, 2011, at 3:03 AM, Igor Grinberg wrote:
>
>>> Bare-bones board file, comes with serial console, gpio keys,
>>> MMC/SDCard and USB support.
>>>
>>> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>>> ---
>> In general, here you should write the version history of your patch...
> umm, ok.
> Do you think the history of the changes is important in this case, though?
> I mean it's mostly the case of "kill unneeded includes, fix style, fix incorrect mux package type" and so on.
> Nothing of real interest to anybody.

It can help everybody (also yourself), for example, the fact that you
already contacted Russell regarding mach-types (though the better place
for it is cover letter) could help me to not wonder why do you have this
stuff here.


-- 
Regards,
Igor.
