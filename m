From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 14:13:09 -0500 (EST)
Subject: [PATCH 14/16] ARM: TC2: ensure powerdown-time data is flushed
 from cache
In-Reply-To: <20130110185052.GF29952@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-15-git-send-email-nicolas.pitre@linaro.org>
 <20130110185052.GF29952@linaro.org>
Message-ID: <alpine.LFD.2.02.1301101410540.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Dave Martin wrote:

> On Wed, Jan 09, 2013 at 07:20:49PM -0500, Nicolas Pitre wrote:
> > From: Dave Martin <dave.martin@linaro.org>
> 
> To avoid confusion, the prefix in the subject line should be "CCI", not
> "TC2".

Absolutely.  This is my mistake as I removed the TC2 changes from your 
original patch to only keep the CCI ones, but forgot to update the patch 
title.


Nicolas
