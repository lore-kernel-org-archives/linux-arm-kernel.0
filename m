From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Jul 2012 17:59:40 -0300
Subject: MX28 poweroff issue
In-Reply-To: <CAOMZO5DDhhZ4WV9Gweb+rYASE8D-KyX7Q6FCQyKbqcVzfOcBMQ@mail.gmail.com>
References: <201207040030.36713.marex@denx.de>
 <20120704151944.GB18739@n2100.arm.linux.org.uk>
 <20120705160855.GA20175@S2101-09.ap.freescale.net>
 <201207051823.26243.marex@denx.de>
 <CAOMZO5DDhhZ4WV9Gweb+rYASE8D-KyX7Q6FCQyKbqcVzfOcBMQ@mail.gmail.com>
Message-ID: <CAOMZO5CAEp8Y7j3+GnhFeoFTEBLaGg5Go=YaGx14zWzSd1W+hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 5:32 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Marek,
>
> On Thu, Jul 5, 2012 at 1:23 PM, Marek Vasut <marex@denx.de> wrote:
>
>> Won't mdelay() be better?
>>
>> It removes the warning, but can't some other stray interrupt trigger it again?
>
> Could you please try the change below? I do not have access to my mx28
> right now.

Nevermind. It still does not work. I will try again tomorrow.
