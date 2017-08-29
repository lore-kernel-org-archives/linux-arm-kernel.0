From: js@sig21.net (Johannes Stezenbach)
Date: Tue, 29 Aug 2017 15:53:41 +0200
Subject: [PATCH 0/3] PM / ACPI / i2c: Runtime PM aware system sleep
 handling
In-Reply-To: <CAPDyKFp5dpuUeRjmmSSA3sZzFVwJihmzteyCDzqG33s2Xb1ewA@mail.gmail.com>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <4245176.X6JjkhnUAM@aspire.rjw.lan>
 <20170829102927.5lpjkfj2jbtpxadm@sig21.net>
 <CAPDyKFp5dpuUeRjmmSSA3sZzFVwJihmzteyCDzqG33s2Xb1ewA@mail.gmail.com>
Message-ID: <20170829135341.moanebdmbdz3ajjm@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 01:44:11PM +0200, Ulf Hansson wrote:
> Did you try out my series (v2) if that could fix this problem in a
> more flexible manner?
> 
> In other words, is it fine if the device remains runtime PM enabled
> during the entire device_suspend() phase, and also not being suspended
> until ->suspend_late()?

I tried to try but I also had some test patches applied
and it hung up on suspend but I ran out of time to check why...
I intend to try again soon.

Johannes
