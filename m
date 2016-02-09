From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 9 Feb 2016 13:49:13 +0100
Subject: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
In-Reply-To: <20160205145146.34ec4eb9.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
 <CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
 <20160201132228.2634b72e.drivshin.allworx@gmail.com>
 <20160201185952.GN19432@atomide.com> <20160202162330.GA4918@ulmo>
 <20160202184443.1e1b0bf5.drivshin.allworx@gmail.com>
 <20160203141454.GC9650@ulmo>
 <20160205145146.34ec4eb9.drivshin.allworx@gmail.com>
Message-ID: <56B9E049.5080700@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2016 08:51 PM, David Rivshin (Allworx) wrote:
> 
> Either way, I think any changes along these lines would probably be 
> cleaner ontop of the atomic update work (assuming some form of that 
> gets merged). And since it would also be outside the scope of this 
> patchset, you may still want to consider the simple debug message 
> in this patch as at least an interim state.
> 

Sure, we should push these patches and rework this one later.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
