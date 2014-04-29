From: lznuaa@gmail.com (Frank Li)
Date: Tue, 29 Apr 2014 09:18:41 -0500
Subject: [PATCH net-next 5/7] net:fec: add support for dumping transmit
 ring on timeout
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F701524@AcuExch.aculab.com>
References: <1398773350-7293-1-git-send-email-Frank.Li@freescale.com>
 <1398773350-7293-5-git-send-email-Frank.Li@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F7014F0@AcuExch.aculab.com>
 <CAHrpEqSCSw=bYgx5Egk4Mva-CODnw5=vvK6y3VWmB3_QpBQ8sQ@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F701524@AcuExch.aculab.com>
Message-ID: <CAHrpEqRZ1oyd6bXXqxznfw+1qwo5LVBW10mcrzLbbCHYowPetA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 9:01 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Frank ...
>> > You probably want the read and write indexes as well.
>>
>>                      bdp == fep->cur_tx ? 'S' : ' ',
>>                      bdp == fep->dirty_tx ? 'H' : ' ',
>>
>> Above code already print read and write index. 'S', 'H'
>
> Gah I must be asleep!
> Something made be think that was to do with the ring ownership bit!

I think it is same thing. If I am wrong, please tell me difference.

>
>         David
>
