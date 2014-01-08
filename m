From: john.tobias.ph@gmail.com (John Tobias)
Date: Wed, 8 Jan 2014 12:45:44 -0800
Subject: [PATCH v3] ARM: imx: add select on ARCH_MXC for cpufreq support
In-Reply-To: <CAOMZO5DR0YGc=V5PJ6xy5PNwa9LCVfnS9gbRh1yW9wLo_oTEtw@mail.gmail.com>
References: <1389210991-23688-1-git-send-email-john.tobias.ph@gmail.com>
 <1389211403.678513817@f123.i.mail.ru>
 <CAOMZO5DR0YGc=V5PJ6xy5PNwa9LCVfnS9gbRh1yW9wLo_oTEtw@mail.gmail.com>
Message-ID: <CACUGKYPZefRPr73Wq+700qeFiDYHmLr4kSFCvkYRojHoE4ZxxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

How about select HAVE_IMX_ANATOP if SOC_IMX6Q || SOC_IMX6SL

Regards,

john

On Wed, Jan 8, 2014 at 12:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jan 8, 2014 at 6:03 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>
>> Maybe better:
>> select HAVE_IMX_ANATOP if ARCH_MULTI_V6_V7
>
> mx31, mx35, mx51 and mx53 do not have this ANATOP block.
>
> Regards,
>
> Fabio Estevam
