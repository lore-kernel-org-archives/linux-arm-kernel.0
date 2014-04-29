From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 29 Apr 2014 14:01:54 +0000
Subject: [PATCH net-next 5/7] net:fec: add support for dumping transmit
 ring on timeout
In-Reply-To: <CAHrpEqSCSw=bYgx5Egk4Mva-CODnw5=vvK6y3VWmB3_QpBQ8sQ@mail.gmail.com>
References: <1398773350-7293-1-git-send-email-Frank.Li@freescale.com>
 <1398773350-7293-5-git-send-email-Frank.Li@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F7014F0@AcuExch.aculab.com>
 <CAHrpEqSCSw=bYgx5Egk4Mva-CODnw5=vvK6y3VWmB3_QpBQ8sQ@mail.gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F701524@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank ...
> > You probably want the read and write indexes as well.
> 
>                      bdp == fep->cur_tx ? 'S' : ' ',
>                      bdp == fep->dirty_tx ? 'H' : ' ',
> 
> Above code already print read and write index. 'S', 'H'

Gah I must be asleep!
Something made be think that was to do with the ring ownership bit!

	David
