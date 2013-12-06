From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 6 Dec 2013 19:05:06 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <878uvx4pyr.fsf@natisbad.org>
References: <20131202103305.GB2466@localhost> <87siubneuf.fsf@natisbad.org>
 <20131203002225.GA5333@localhost> <87ob4xbs8l.fsf@natisbad.org>
 <87iov5aapx.fsf@natisbad.org> <20131204142009.GB2486@localhost>
 <87haaogx6j.fsf@natisbad.org> <87d2lbrpvy.fsf@natisbad.org>
 <20131206125559.GA4208@localhost> <878uvx4pyr.fsf@natisbad.org>
Message-ID: <20131206220505.GB2458@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 10:41:32PM +0100, Arnaud Ebalard wrote:
> Hi Ezequiel,
> 
> Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:
> 
> > Hi Arnaud,
> >
> > On Thu, Dec 05, 2013 at 09:42:25PM +0100, Arnaud Ebalard wrote:
> > [..]
> >> [ 1488.150697] Waiting for device to be ready
> >> [ 1488.150702] Device is ready
> >> 
> >> If you had the time to test the offending block on another device, did
> >> you manage to reproduce what I get?
> >> 
> >
> > Yes, I managed to reproduced your timeout. You found a bug on my
> > dev_ready completion handler scheme, and now I officially hate this
> > evil completion handler ;-)
> >
> > I've pushed a new branch for you to try:
> >
> > https://github.com/MISL-EBU-System-SW/mainline-public/tree/pxa3xx-armada-nand-new-ecc-v2
> >
> > Please give it a try, and test as heavily and creatively as you can
> > think off.
> 
> Sorry, but I was unable to find any more bug, i.e. AFAICT it does work
> as expected now :-) FWIW, thanks for your time, you can put my:
> 
> Tested-by: Arnaud Ebalard <arno@natisbad.org>
> 

Great! I'll push the patches then with your tested-by.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
