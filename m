From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 15 Jan 2013 03:38:12 -0800
Subject: rtc: vt8500: Fix year field in vt8500_rtc_set_time
In-Reply-To: <1358234563.6868.13.camel@gitbox>
References: <1358234563.6868.13.camel@gitbox>
Message-ID: <20130115113812.GE1748@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 08:22:43PM +1300, Tony Prisk wrote:
> Alessandro,
> 
> This patch was sent out at the same time as two other RTC fixes for
> vt8500 but this one seems to have stopped somewhere along the way while
> the other two have been accepted.
> 
> The patch is showing in the RTC patch system along with the other two:
> http://patchwork.ozlabs.org/patch/208756/
> 
> 
> Greg,
> How did the first two patches find their way to you - did you pick them
> up off one of the lists?

I have no idea, normally rtc patches go through Andrew Morton.
