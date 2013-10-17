From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 17 Oct 2013 13:53:30 +0900
Subject: [PATCH] ARM: shmobile: Cosmetic update of Lager DT Reference
In-Reply-To: <20131017010657.GH21728@verge.net.au>
References: <20131016215819.12718.54556.sendpatchset@w520>
 <20131017010657.GH21728@verge.net.au>
Message-ID: <CANqRtoRHyqp24QCPixxOmokcBusmru6Wx16d7jvGv8L9crctOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Oct 17, 2013 at 10:06 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Oct 17, 2013 at 06:58:19AM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Clean up the Lager DT reference board code to make it match
>> Koelsch DT reference including using the rcar-gen2 header.
>
> This is getting dangerously close to churn.
> Do you really want me to take this change?

I don't mind so much, but I think that the idea of keeping Lager and
Koelsch in the same style makes sense. Would you prefer to split this
up in several patches? There is some whitespace damage and also the
header file inclusion style is different from Koelsch.

Cheers,

/ magnus
