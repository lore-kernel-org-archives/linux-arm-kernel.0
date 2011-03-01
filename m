From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 10:47:23 -0300
Subject: [PATCH 1/2] ARM imx53: add pwm devices support
In-Reply-To: <1298972303-1010-1-git-send-email-b02280@freescale.com>
References: <1298972303-1010-1-git-send-email-b02280@freescale.com>
Message-ID: <AANLkTimCxkN1HKvhoMS7kHBngYxk6jNbz5qTssH4Fz-B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Mar 1, 2011 at 6:38 AM, Jason Chen <b02280@freescale.com> wrote:
...
> - ? ? ? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
> + ? ? ? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51() ||
> + ? ? ? ? ? ? ? cpu_is_mx53()) {

Wouldn?t  "if (!cpu_is_mx1() && !cpu_is_mx21())" work here and make
the if statement simpler?

Regards,

Fabio Estevam
