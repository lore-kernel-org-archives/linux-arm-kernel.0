From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 6 Dec 2013 09:56:00 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87d2lbrpvy.fsf@natisbad.org>
References: <20131128185040.GA13182@localhost> <87bo12kcyt.fsf@natisbad.org>
 <20131202103305.GB2466@localhost> <87siubneuf.fsf@natisbad.org>
 <20131203002225.GA5333@localhost> <87ob4xbs8l.fsf@natisbad.org>
 <87iov5aapx.fsf@natisbad.org> <20131204142009.GB2486@localhost>
 <87haaogx6j.fsf@natisbad.org> <87d2lbrpvy.fsf@natisbad.org>
Message-ID: <20131206125559.GA4208@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Thu, Dec 05, 2013 at 09:42:25PM +0100, Arnaud Ebalard wrote:
[..]
> [ 1488.150697] Waiting for device to be ready
> [ 1488.150702] Device is ready
> 
> If you had the time to test the offending block on another device, did
> you manage to reproduce what I get?
> 

Yes, I managed to reproduced your timeout. You found a bug on my
dev_ready completion handler scheme, and now I officially hate this
evil completion handler ;-)

I've pushed a new branch for you to try:

https://github.com/MISL-EBU-System-SW/mainline-public/tree/pxa3xx-armada-nand-new-ecc-v2

Please give it a try, and test as heavily and creatively as you can think off.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
