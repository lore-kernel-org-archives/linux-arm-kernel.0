From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2011 15:35:30 +0200
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel
	Summit 2011
In-Reply-To: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
Message-ID: <CACRpkdawG9aKAT7PHuYapiHexkteq-_seQGd6iRORyt-LwbmxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 8:00 AM, Grant Likely <grant.likely@secretlab.ca> wrote:

> Nominates, but haven't responded personally:
> (...)
> 22) Linus Walleji

I won't be coming, sorry friends.

> Agenda proposals (Thanks to Nicolas and Olof):
> - the pin mux subsystem from linusw (especially if it is still RFC by
> ?then)

I will be happy to attend by wire if provided the necessary details.
pin control with mux basics is in -next and I am iterating next design
step with Stephen Warren from nVidia.

> Still accepting more proposals. ?Send me the topics you are burning to discuss.

Since I'm not coming I don't know how relevant my opinions are.

But a topic which I think is important is:
"Subsystems! Subsystems! Subsystems!"
(Bonus if you get Greg to shout this dancing on stage.)

We have noticed a lack of subsystems such as pin control to
compartmentalize "stuff" currently stacking up in arch/arm/*
drivers/misc/* and drivers/mfd/*.

The problem of how to adress this the proper way by creating
new subsystems need to be shed some light upon, just telling
every subarch to "go create a new subsystem, it'll just take a
few man-years of your working hours" apparently does not always
work.

On a related key is the need to get the stuff in drivers/staging/iio
into drivers/ proper.

Just my ?0.01..

BR,
Linus Walleij
