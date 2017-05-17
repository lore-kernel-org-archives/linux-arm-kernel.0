From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 17 May 2017 11:26:57 +0800
Subject: [PATCH V2 2/6] tty: serial: lpuart: add little endian 32 bit
 register support
In-Reply-To: <CAHp75VeGKzDfwi1zMz+u5WZWmqnJkE41n8gw+uWcce8ngXrm2w@mail.gmail.com>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
 <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <CAHp75VeGKzDfwi1zMz+u5WZWmqnJkE41n8gw+uWcce8ngXrm2w@mail.gmail.com>
Message-ID: <20170517032657.GA9913@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 04:36:25PM +0300, Andy Shevchenko wrote:
> On Mon, May 15, 2017 at 10:48 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> > It's based on the exist lpuart32 read/write implementation.
> 
> Same as per previous comment (perhaps not in other UART driver, but
> some might have been using device property for that.
> 

The reason why we do that is: a) we don't want to make a churn on the
exist users. b) it's not really necessary to use dt property
when we already have a soc_data as it has no much benefit but introduce
overhead.

Regards
Dong Aisheng

> 
> -- 
> With Best Regards,
> Andy Shevchenko
