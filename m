From: lznuaa@gmail.com (Frank Li)
Date: Tue, 29 Apr 2014 09:22:13 -0500
Subject: [PATCH net-next 5/7] net:fec: add support for dumping transmit
 ring on timeout
In-Reply-To: <20140429141527.GZ26756@n2100.arm.linux.org.uk>
References: <1398773350-7293-1-git-send-email-Frank.Li@freescale.com>
 <1398773350-7293-5-git-send-email-Frank.Li@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F7014F0@AcuExch.aculab.com>
 <CAHrpEqSCSw=bYgx5Egk4Mva-CODnw5=vvK6y3VWmB3_QpBQ8sQ@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F701524@AcuExch.aculab.com>
 <20140429141527.GZ26756@n2100.arm.linux.org.uk>
Message-ID: <CAHrpEqTc6=yS4ApLO7AbZyVq26kGxq+WBcyFjgjbiPySq7055Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 9:15 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 29, 2014 at 02:01:54PM +0000, David Laight wrote:
>> From: Frank ...
>> > > You probably want the read and write indexes as well.
>> >
>> >                      bdp == fep->cur_tx ? 'S' : ' ',
>> >                      bdp == fep->dirty_tx ? 'H' : ' ',
>> >
>> > Above code already print read and write index. 'S', 'H'
>>
>> Gah I must be asleep!
>> Something made be think that was to do with the ring ownership bit!
>
> Err, what's going on... this is my patch.  If it's been submitted by
> others, why wasn't its submission at least Cc'd to me?

I added " --to rmk+kernel at arm.linux.org.uk" when I send patch.
I don't know what's wrong.
I kept your name.

I ask you if need someone help send to david millar before.

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
