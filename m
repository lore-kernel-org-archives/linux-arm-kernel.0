From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 07:23:27 +0800
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <201112192154.25310.marek.vasut@gmail.com>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <201112191257.06145.marek.vasut@gmail.com>
 <20111219121559.GF14542@n2100.arm.linux.org.uk>
 <201112192154.25310.marek.vasut@gmail.com>
Message-ID: <20111219232325.GA5683@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 09:54:25PM +0100, Marek Vasut wrote:
> > So, in summary, you have everything you require to fix it outside the
> > driver.  You just have to decide which of the two options you want to
> > proceed with, and actually (and finally) do it instead of endlessly
> > procrastinating and waiting for more and more bug reports (which is
> > exactly what has happened so far.)
> 

Marek, the 'you' here really means me rather than you.

Russell, sorry for leaving the issue here for long time, and I'm working
on the patches you suggested right now.

Regards,
Shawn

> What the hell, I just recently found this bug and I submitted a patch right 
> away! What are you complaining about?!
> 
> Grumble!
> 
> But thanks for the explanation!
> 
> M
> 
