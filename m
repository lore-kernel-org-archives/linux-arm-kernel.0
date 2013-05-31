From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 31 May 2013 12:12:26 -0300
Subject: [PATCHv2 1/3] arm: introduce config HAS_BANDGAP
In-Reply-To: <1368629928-6723-2-git-send-email-eduardo.valentin@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-2-git-send-email-eduardo.valentin@ti.com>
Message-ID: <CAOMZO5CL=apxbkCHA6Xsw+m5d-rhe_VcOaA9KpkSmiJ=ZRL7gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:58 AM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Introduce HAS_BANDGAP config entry. This config is a
> boolean value so that arch code can flag is they
> feature a bandgap device.
>
> This config entry follows the same idea behind
> ARCH_HAS_CPUFREQ.

It would be nice if you explain what BANDGAP means here, since you
introduce this option in this patch.
