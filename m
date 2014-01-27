From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Mon, 27 Jan 2014 17:42:49 +0100
Subject: imx6: usbhc2/3 and HSIC
In-Reply-To: <1390815772.4847.9.camel@weser.hi.pengutronix.de>
References: <CAH9NwWckD5Rmr9oW2Gr071V2p0FjRJcttYpB4qQNEWTxDEJ6qw@mail.gmail.com>
 <1390815772.4847.9.camel@weser.hi.pengutronix.de>
Message-ID: <CAH9NwWf8rc+PJygNP45x669nyiPqirF_PHOXGEQ_CX7PWaB7pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas

2014-01-27 Lucas Stach <l.stach@pengutronix.de>:
> Hi Christian,
>
> Am Montag, den 27.01.2014, 10:22 +0100 schrieb Christian Gmeiner:
>> Hi all...
>>
>> does anyone used the usbhc2 or usbhc3 in HSIC mode? I am trying my
>> luck but I do not
>> get it to work. Is there anything special I need to take care of?
>>
> I remember we had this working on a board back in the 3.10 days. The
> only thing I remember which is specific to HSIC is in the attached
> patch. This isn't really clean and should be done in a better way for
> mainline, but maybe it provides some pointers for you.
>

Thanks for the small patch... I got it almost working - the HSIC
device seems to have some problems.
I hope to find some time soon to get this stuff into mainline.

greets
--
Christian Gmeiner, MSc
