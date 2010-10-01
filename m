From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 1 Oct 2010 04:39:21 +0200
Subject: [PATCH 1/3] ARM: move timer-sp.c from versatile to common
In-Reply-To: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
References: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
Message-ID: <20101001023921.GB25320@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:49 Thu 30 Sep     , Rob Herring wrote:
> From: Rob Herring <rob.herring@smooth-stone.com>
> 
> The timer-sp h/w used on versatile platforms can also be used for other
> platforms, so move it to a common location.
> 
> Rename timer names for clocksource and clockevent to generic name.
> Which timer instance is which is platform dependent.
> 
How about move it to drivers/clocksource ?

Best Regards,
J.
