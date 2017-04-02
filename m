From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 2 Apr 2017 16:16:26 +0300
Subject: [PATCH v2 4/5] serial: split generic UART driver helper functions
 into a separate file
In-Reply-To: <20170401222119.25106-5-nicolas.pitre@linaro.org>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <20170401222119.25106-5-nicolas.pitre@linaro.org>
Message-ID: <CAHp75Ve_O03CQQErkaHPyAbxrQFe=uWf7mmmZuJ+rVNJysqGSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 2, 2017 at 1:21 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> This contains code that is common between serial_core.c and the
> minitty code to come. Mainly helper functions used by UART drivers.


I have two questions:
- why minitty (what is that by the way?) can't use serial_core.c as a library?
- does -M -C help to make this diff shorter?

-- 
With Best Regards,
Andy Shevchenko
