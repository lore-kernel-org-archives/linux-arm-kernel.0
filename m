From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Jan 2014 18:33:00 -0200
Subject: [PATCH v3] ARM: imx: add select on ARCH_MXC for cpufreq support
In-Reply-To: <1389211403.678513817@f123.i.mail.ru>
References: <1389210991-23688-1-git-send-email-john.tobias.ph@gmail.com>
 <1389211403.678513817@f123.i.mail.ru>
Message-ID: <CAOMZO5DR0YGc=V5PJ6xy5PNwa9LCVfnS9gbRh1yW9wLo_oTEtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 6:03 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

> Maybe better:
> select HAVE_IMX_ANATOP if ARCH_MULTI_V6_V7

mx31, mx35, mx51 and mx53 do not have this ANATOP block.

Regards,

Fabio Estevam
