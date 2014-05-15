From: dwalker@fifo99.com (dwalker at fifo99.com)
Date: Thu, 15 May 2014 17:44:48 +0000
Subject: [PATCH] arm: msm: remove board file for Nexus One (ie. mahimahi)
In-Reply-To: <1400101656.9826.4.camel@x220>
References: <1400101656.9826.4.camel@x220>
Message-ID: <20140515174448.GA31159@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 11:07:36PM +0200, Paul Bolle wrote:
> Commit 1b802ff79f03 ("arm: msm: add board file for Nexus One (ie.
> mahimahi)") added just board-mahimahi.c. It did not add
> board-mahimahi.h, Makefile changes or Kconfig changes.
> 
> Four years have passed and this file is still dangling. Remove it.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested. But what to test here?
> 

I don't mine if Sapphire gets removed, but I'm working on this one now.. So I don't want it deleted.

Daniel
