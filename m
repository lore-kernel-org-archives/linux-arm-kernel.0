From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Aug 2014 14:05:25 -0300
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <53FB1041.5010208@lategoodbye.de>
References: <53F9B4BF.2050802@lategoodbye.de> <20140825080123.GA12289@dragon>
 <53FB1041.5010208@lategoodbye.de>
Message-ID: <CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Mon, Aug 25, 2014 at 7:30 AM, Stefan Wahren <info@lategoodbye.de> wrote:

> As far as i know, the old Freescale BSP (2.6.35) contains a cpufreq driver
> for mxs, which never goes to mainline. So i'm not sure what would be the
> best way: porting the old driver or using cpufreq-cpu0.

First step would be to port the PMU driver into mainline.
