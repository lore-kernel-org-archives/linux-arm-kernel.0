From: srishtishar@gmail.com (srishti sharma)
Date: Sat, 24 Jun 2017 09:00:21 +0530
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c:
 Fixed alignment to match open parenthesis
In-Reply-To: <CAB3L5oza-wcxG6T01sCzDiatcUCx1L0uBtJR4C2Y9NLka-LqbA@mail.gmail.com>
References: <1497468895-3061-1-git-send-email-srishtishar@gmail.com>
 <20170623162055.GB21608@kroah.com>
 <CAB3L5oza-wcxG6T01sCzDiatcUCx1L0uBtJR4C2Y9NLka-LqbA@mail.gmail.com>
Message-ID: <CAB3L5oyA5Z9DKQj=83qQNZnmTL=O20x1KusGKzaJt02Fzcx2Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 24, 2017 at 8:11 AM, srishti sharma <srishtishar@gmail.com> wrote:
> On Fri, Jun 23, 2017 at 9:50 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Thu, Jun 15, 2017 at 01:04:55AM +0530, srishti sharma wrote:
>>> Fixed alignment so that it matched open parenthesis.
>>>
>>> Signed-off-by: srishti sharma <srishtishar@gmail.com>
>>> ---
>>>  .../staging/vc04_services/bcm2835-audio/bcm2835-ctl.c  | 18 +++++++++---------
>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> What differs from your previous patch?
>
> The previous patch had only one check fixed , this has all checks of
> the type = parenthesis_alignment in the file bcm2835-ctl.c fixed .
> Also there was a typo in the description of the previous patch so I
> corrected that .
>
>    Always properly version your
>> patch so we know what to take.
>>
>> Please fix and resend.

I have re-sent version 2 .
>>
>> thanks,
>>
>> greg k-h
>

Regards,
Srishti
