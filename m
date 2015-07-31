From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 12:20:09 +0200
Subject: [PATCH 00/23] ARM: at91: Properly handle slow clock
In-Reply-To: <20150731115903.4ef23e83@bbrezillon>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150731115903.4ef23e83@bbrezillon>
Message-ID: <20150731102009.GH27985@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31/07/2015 at 11:59:03 +0200, Boris Brezillon wrote :
> I would have squashed commit 5 to 14 into a single patch, but apart
> from that it looks good to me.
> 

I wanted to clearly list were the slow clock was needed for each soc. It
actually allowed me to find one that was missing.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
