From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 15 May 2017 16:36:25 +0300
Subject: [PATCH V2 2/6] tty: serial: lpuart: add little endian 32 bit
 register support
In-Reply-To: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
 <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAHp75VeGKzDfwi1zMz+u5WZWmqnJkE41n8gw+uWcce8ngXrm2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 10:48 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> It's based on the exist lpuart32 read/write implementation.

Same as per previous comment (perhaps not in other UART driver, but
some might have been using device property for that.


-- 
With Best Regards,
Andy Shevchenko
