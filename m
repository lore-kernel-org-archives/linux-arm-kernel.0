From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 22 Nov 2013 16:50:42 -0300
Subject: [PATCH v4 0/4] pm: Add power off control
In-Reply-To: <CA+Bv8XbUa7xPd8V7LQCmFbbdQvORUK1X0xBPzAhKUFFjjho2jw@mail.gmail.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
 <CA+Bv8XbUa7xPd8V7LQCmFbbdQvORUK1X0xBPzAhKUFFjjho2jw@mail.gmail.com>
Message-ID: <20131122195041.GF18968@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russ,

On Fri, Jan 11, 2013 at 12:09:56AM -0800, Russ Dill wrote:
> I personally like the series, it certainly adds needed functionality.
> I just wish there was a way to get it without a possible 4 second
> delay.
> 

I was just going through this patches and got confused by the same
thing, could you explain me *why* are those waitings requried?

And why specifically *2* seconds, instead of *1* or *33* ?

Sounds a bit like voodoo magic on this side :-)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
