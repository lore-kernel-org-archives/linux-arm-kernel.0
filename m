From: jean-michel.hautbois@veo-labs.com (Jean-Michel Hautbois)
Date: Fri, 6 Nov 2015 17:54:17 +0100
Subject: i.MX6: Oops when unplugging a USB key
In-Reply-To: <4306403.1Q6hpl8dCg@wuerfel>
References: <CAH-u=81BFm1nquN5z7hFN9auV=9dPMPkRFX_PneK22UXgPbJnA@mail.gmail.com>
 <4306403.1Q6hpl8dCg@wuerfel>
Message-ID: <CAH-u=83oF-cJTCqfA3Onnc4TBGTa7+kCE6sBttUcfWy_r79zzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-11-06 17:38 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 06 November 2015 17:32:30 Jean-Michel Hautbois wrote:
>> I have an issue on my i.MX6 board I don't understand (kernel is a 4.2)...
>> When I connect a USB key, and then disconnect it, it oopses and
>> reboots (as I have panic on oops, and reboot on panic).
>> Seems to be on the umount part...
>> The USB is connected through a smsc95xx but I don't think this is related...
>
> You should normally unmount the file system before unplugging.
>
> Did this work on other kernels? What happens if you unplug
> that stick on your laptop while the file system is mounted?

It worked well, it will not write the last dirty page if any that's all...

JM
