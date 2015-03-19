From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 19 Mar 2015 14:30:50 +0100
Subject: ATSAMA5D big endian work
In-Reply-To: <550A9833.2080408@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <20150318183040.GT4560@piout.net>
 <550A9833.2080408@codethink.co.uk>
Message-ID: <20150319133050.GD4750@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/2015 at 09:34:43 +0000, Ben Dooks wrote :
> On 18/03/15 18:30, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 18/03/2015 at 15:52:59 +0000, Ben Dooks wrote :
> >> I have been testing the ATSAMA5D36 xplained board with big endian and
> >> the following are the fixes to get the system working.
> >>
> > 
> > The series looks good to me, we will drop patches 3 and 4 as the files
> > doesn't exist anymore.
> 
> Where can I find a repository with these changes in?
> 

You can use this branch until Nicolas merges my patches:

https://github.com/alexandrebelloni/linux/tree/at91_4.1_04_cleanup2

The remaining __raw_writel and __raw_readl are in pm.h

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
