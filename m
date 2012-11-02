From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 2 Nov 2012 09:43:24 +0100
Subject: [PATCH 0/4] Support the MX6 FEC as a PTP hardware clock
In-Reply-To: <CAHrpEqRuy=kewK-592RphVfJnNoma2CPZytoTqLc45HeT53hRQ@mail.gmail.com>
References: <1351657480-24745-1-git-send-email-Frank.Li@freescale.com>
 <20121101.123027.1332984905040252720.davem@davemloft.net>
 <CAHrpEqRuy=kewK-592RphVfJnNoma2CPZytoTqLc45HeT53hRQ@mail.gmail.com>
Message-ID: <20121102084324.GA2486@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 10:36:09AM +0800, Frank Li wrote:
> >
> > All applied to net-next.
> >
> > Please make sure your changes are in sync with Ben's PTP/PPS
> > Kconfig changes of today, and send me any changes if necessary.
> >
> 
> Thank you very much.
> I checked Ben's patch, which not affect FEC.

Maybe just remove the Kconfig line "select PPS".

Thanks,
Richard
