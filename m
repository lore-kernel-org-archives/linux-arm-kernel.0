From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 9 Jul 2018 09:15:06 +0300
Subject: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
In-Reply-To: <20180709140435.3996588b@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
 <20180704170310.56772d77@xhacker.debian>
 <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
 <20180705143921.6a8aeb50@xhacker.debian>
 <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
 <20180709140435.3996588b@xhacker.debian>
Message-ID: <CAHp75VcyzV8KmPx=NXe=4s2eOTRups=XU8L4UHP3eWr=1TH7Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 9:04 AM, Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Fri, 6 Jul 2018 20:37:09 +0300 Andy Shevchenko wrote:

> yes, makes sense. Will send a new version soon.
Please, be sure you base it on top of tty-next and there is no
warnings added (makes sense to run make W=1 as well),

-- 
With Best Regards,
Andy Shevchenko
