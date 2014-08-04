From: grant.b.edwards@gmail.com (Grant Edwards)
Date: Mon, 4 Aug 2014 19:11:10 +0000 (UTC)
Subject: Building kernel for more than one SoC
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140731230737.66e94c3d@free-electrons.com>
Message-ID: <lrolse$35s$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-07-31, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> I don't think there's much point in worrying about this: the 9G20 and
> 9G25 will use identical device drivers for the vast majority of the
> hardware blocks of the SoC,

Really identical drivers, or just compiled from the same source file?
One thing I'm worried about is that they might share a driver that has
code conditionally compiled one way for the G20 and the other for the
G25.  I haven't _found_ any code like that yet, but it would be a pain
to have to deal with something like that...

-- 
Grant Edwards               grant.b.edwards        Yow! I want to dress you
                                  at               up as TALLULAH BANKHEAD and
                              gmail.com            cover you with VASELINE and
                                                   WHEAT THINS ...
