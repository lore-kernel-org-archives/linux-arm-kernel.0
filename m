From: stigge@antcom.de (Roland Stigge)
Date: Wed, 04 Apr 2012 02:11:12 +0200
Subject: [PATCH] gpio: Fix range check in of_gpio_simple_xlate()
In-Reply-To: <1333497778-26925-1-git-send-email-stigge@antcom.de>
References: <1333497778-26925-1-git-send-email-stigge@antcom.de>
Message-ID: <4F7B91A0.4070709@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/12 02:02, Roland Stigge wrote:
> This patch fixes a range check in of_gpio_simple_xlate() by replacing a
> "> gc->ngpio" with ">= gc->ngpio" since range is from 0 to gc->ngpio - 1
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

CC: stable at vger.kernel.org
