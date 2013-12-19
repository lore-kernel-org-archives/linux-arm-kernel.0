From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 19:05:49 +0100
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <20131219184024.2a649328@linux.lan.towertech.it> (Alessandro
 Zummo's message of "Thu, 19 Dec 2013 18:40:24 +0100")
References: <87siton6ke.fsf@natisbad.org>
 <20131219173857.0a546b99@linux.lan.towertech.it>
 <87d2kslphr.fsf@natisbad.org>
 <20131219184024.2a649328@linux.lan.towertech.it>
Message-ID: <8761qkk96q.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alessandro Zummo <a.zummo@towertech.it> writes:

>> Do you want me to send a v7 w/ the .proc helper removed or leave
>> things as they are and Ack the patch as is?
>
>  Unless absolutely needed, I'd prefer if you can remove them
>  or move to sysfs.

Well, my helper provides info on control and status registers flags
(just like rtc-isl1208.c does), which are useful mainly for debug I
guess. If this can help pushing things forward, I will send a v7 later
today w/ the .proc helper removed from the patch.

Cheers,

a+
