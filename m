From: briannorris@chromium.org (Brian Norris)
Date: Wed, 7 Dec 2016 11:03:02 -0800
Subject: [PATCH 4/9] arm64: dts: rockchip: support dwc3 USB for rk3399
In-Reply-To: <1972184.o3UeJg0tK9@phil>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <2947180.ggfADt6cbn@phil> <20161207175208.GB87970@google.com>
 <1972184.o3UeJg0tK9@phil>
Message-ID: <20161207190301.GA107036@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 08:01:23PM +0100, Heiko Stuebner wrote:
> Am Mittwoch, 7. Dezember 2016, 09:52:08 CET schrieb Brian Norris:
> > But pcie at f8000000 is also out of order then. I guess maybe
> > that's the only one then.
> 
> Yep, pcie is misplaced as sadly sometimes I miss those errors as well.

OK. Do you want me to patch that at the end of my series, or is that
unnecessary churn?

Brian
