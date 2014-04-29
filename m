From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Apr 2014 15:15:27 +0100
Subject: [PATCH net-next 5/7] net:fec: add support for dumping transmit
 ring on timeout
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F701524@AcuExch.aculab.com>
References: <1398773350-7293-1-git-send-email-Frank.Li@freescale.com>
 <1398773350-7293-5-git-send-email-Frank.Li@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F7014F0@AcuExch.aculab.com>
 <CAHrpEqSCSw=bYgx5Egk4Mva-CODnw5=vvK6y3VWmB3_QpBQ8sQ@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F701524@AcuExch.aculab.com>
Message-ID: <20140429141527.GZ26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 02:01:54PM +0000, David Laight wrote:
> From: Frank ...
> > > You probably want the read and write indexes as well.
> > 
> >                      bdp == fep->cur_tx ? 'S' : ' ',
> >                      bdp == fep->dirty_tx ? 'H' : ' ',
> > 
> > Above code already print read and write index. 'S', 'H'
> 
> Gah I must be asleep!
> Something made be think that was to do with the ring ownership bit!

Err, what's going on... this is my patch.  If it's been submitted by
others, why wasn't its submission at least Cc'd to me?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
