From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 31 Jan 2012 08:53:29 -0200
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <20120131085637.GM1990@pengutronix.de>
References: <20120127111024.GB5446@pengutronix.de>
 <CAOesGMj4k3NcXMh3WtegJgejdDK1QntDnyudD6Ky8Ou6mN3cBg@mail.gmail.com>
 <20120131085637.GM1990@pengutronix.de>
Message-ID: <CAOMZO5ARnTLrO_+5q+tU501Y2qL5xh8SOM74KU8T9A_+2vCJFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 6:56 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

>
> I understood that the second patch is a bugfix and that it depends on
> the first one. Fabio, can you comment on this?

Yes, this is correct.

The bugfix that my patch addresses is the fact that mx35 is not
entering LPM (low power mode) in WFI.
It is using the same behaviour of mx31 and this is not correct for
mx35 due to the different LPM field.

I saw Olof?s feedback about the patch and will address it soon.

Thanks,

Fabio Estevam
