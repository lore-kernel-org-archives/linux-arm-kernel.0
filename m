From: k.marinushkin@gmail.com (Kirill Marinushkin)
Date: Tue, 24 Apr 2018 20:51:34 +0200
Subject: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
In-Reply-To: <CAHp75Vd=_7g4N6b2Mkw1dLOao6gFsQuhzO7-9d=1kjyX0kgMAQ@mail.gmail.com>
References: <20180424071618.GB17825@kroah.com>
 <20180424074459.7215-1-k.marinushkin@gmail.com>
 <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
 <CAHp75Vd=_7g4N6b2Mkw1dLOao6gFsQuhzO7-9d=1kjyX0kgMAQ@mail.gmail.com>
Message-ID: <2c7fc106-4c57-5e55-4f45-8fcf03a40dda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/18 20:35, Andy Shevchenko wrote:
> On Tue, Apr 24, 2018 at 9:27 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>
>> @Andy
>>
>>> AFAIR I gave you a tag and you again missed it.
>>> Before sending anything just check twice if all prerequisites are fulfilled.
>> I think you mix it up. This is a new patch, you didn't review it before.
> Ah, okay, send new version as a separate thread and if I have time I
> would review it.
>

Thank you!
But it will be in the same thread. From my understanding, keeping the thread
when sending new versions of a patch helps to keep tracking of the conversation
