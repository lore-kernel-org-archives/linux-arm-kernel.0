From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 4 Jul 2011 02:43:04 +0400
Subject: [PATCH V2 0/2] Suspend for gpio-vbus support
In-Reply-To: <4E105B34.3080908@mvista.com>
References: <1309615344-12714-1-git-send-email-dbaryshkov@gmail.com>
	<4E105B34.3080908@mvista.com>
Message-ID: <CALT56yOcgV09oFXE5E-tsbqzxEOeA_qOgW2j0wEU0JYqny_Mrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/3/11, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 02-07-2011 18:02, Dmitry Eremin-Solenikov wrote:
>
>> Previous version of these patches generated quite a lot of comments.
>> Now I'd like to present an updated version of this patchset.
>
>> Changes since V1:
>> * Switch to using dev_pm_ops instead of platform_driver hooks
>> * Move suspend/resume to _noirq (LATE) to be sure that otg transceiver
>>    suspends after the main UDC driver.
>
>     Frankly speaking, I don't see where you have done that...

Oops... Sent a previous version of the patchset. Sorry.

>
>> Dmitry Eremin-Solenikov (2):
>>        gpio-vbus: support disabling D+ pullup on suspend
>>        mioa701: move gpio-pullup functionality to gpio-vbus
>
> WBR, Sergei
>


-- 
With best wishes
Dmitry
