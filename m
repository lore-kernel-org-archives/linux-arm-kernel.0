From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Apr 2012 15:53:09 -0600 (MDT)
Subject: [PATCH v4 11/12] ARM: OMAP1: DMTIMER: fix broken timer clock
 source selection
In-Reply-To: <20120417214802.GH21106@atomide.com>
References: <20120411003454.27059.37500.stgit@dusk>
 <20120411003559.27059.1315.stgit@dusk> <20120417214802.GH21106@atomide.com>
Message-ID: <alpine.DEB.2.00.1204171552360.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Apr 2012, Tony Lindgren wrote:

> Uhh looks like this was caused by commit 97933d6 (ARM: OMAP1: dmtimer: conversion
> to platform devices) moving code and changing it :(
> 
> I'll pick this to fixes.

Sounds good, will drop this from my series and send a new pull request.


- Paul
