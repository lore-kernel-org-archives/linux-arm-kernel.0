From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 11 Jul 2011 10:00:42 -0400 (EDT)
Subject: [PATCH 05/17] mach-ks8695: remove leds driver, since nobody use it
In-Reply-To: <CAK5ve-JujN6t5PanWdc89Wgn-6G+K214TkUxoUq1NkS8v6eMEw@mail.gmail.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-6-git-send-email-bryan.wu@canonical.com>
	<CAFumwP1abk+-R-mht9BmKhU9opfVNUjD1PTBha--O6Ts5SCuQg@mail.gmail.com>
	<4E1ADA59.40409@ru.mvista.com>
	<CAK5ve-JujN6t5PanWdc89Wgn-6G+K214TkUxoUq1NkS8v6eMEw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1107110956280.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jul 2011, Bryan Wu wrote:

> On Mon, Jul 11, 2011 at 7:11 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> > Hello.
> >
> > On 09-07-2011 0:23, Andrew Victor wrote:
> >
> >>> Signed-off-by: Bryan Wu<bryan.wu@canonical.com>
> >
> >> As the original author of this code.
> >
> >> Acked-by: Andrew Victor <linux@maxim.org.za>
> >
> > ? If you're the original author, shouldn't there be:
> >
> > From: Andrew Victor <linux@maxim.org.za>
> >
> 
> No problem, I will change that.

Beware.  Is Andrew Victor the original author of the code being removed 
here and in this case he's indicating his agreement to the removal of 
his code, or he is the one actually responsible for the removal?  If the 
former then it is wrong to put a "From" with his name and the 
"Acked-by:" is the right thing to do.


Nicolas
