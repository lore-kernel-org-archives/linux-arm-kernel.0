From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Thu, 5 Jul 2012 23:36:27 +0530
Subject: [PATCH] i2c i.MX: Fix divider table
In-Reply-To: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAM=Q2csv3rEs-xseGd6NHxR3wRSZp82ZqNB1mn-_C4=5=nOc6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 6:40 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Measurements on i.MX1 and i.MX53 have shown that the divider values
> in the datasheets are wrong.
How were the measurements made?

> the values from first, third and fourth
> column were all measured to be 8 higher than in the datasheet. It
> should be safe to assume that the SoCs between i.MX1 and i.MX53 behave
> the same as the i2c unit is unchanged since the i.MX1.

Also does it vary board to board or is fixed by the ip?
What I mean is that the external cap etc.



>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
