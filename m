From: ben@trinity.fluff.org (Ben Dooks)
Date: Thu, 12 Jul 2012 13:31:26 +0100
Subject: [PATCH] ARM: samsung: adc: fix race in s3c_adc_start
In-Reply-To: <1342059131-31251-1-git-send-email-toddpoynor@google.com>
References: <1342059131-31251-1-git-send-email-toddpoynor@google.com>
Message-ID: <20120712123125.GJ18513@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 07:12:11PM -0700, Todd Poynor wrote:
> Checking for adc->ts_pend already claimed should be done with the
> lock held.
> 
> Change-Id: Ic9f15e26bd19934ab8c2885ce5df265933ac304a
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
