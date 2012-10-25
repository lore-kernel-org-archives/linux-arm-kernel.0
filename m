From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Thu, 25 Oct 2012 19:17:28 +0530
Subject: [PATCH 2/2] i2c: omap: make reset a seperate function
In-Reply-To: <20121025105516.GH21217@arwen.pp.htv.fi>
References: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com>
 <1351160586-12306-3-git-send-email-shubhrajyoti@ti.com>
 <20121025105516.GH21217@arwen.pp.htv.fi>
Message-ID: <508942F0.7060100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012 04:25 PM, Felipe Balbi wrote:

>  overflow, underflow
these are data errors personally feel may be removed.

>  and arbitration lost) 
will investigate.
> and try to make sure if
> actually need to reset the controller all the time. I find it really odd
> that we're always resetting the IP in every error condition without
> actually trying to figure out what's wrong with the driver (if there is
> something wrong with the driver, of course).
