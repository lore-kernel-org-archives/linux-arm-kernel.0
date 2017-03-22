From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 22 Mar 2017 20:46:58 +0200
Subject: [PATCH 0/2] serial: Add name field to uart_port
In-Reply-To: <20170321133636.8814-1-vigneshr@ti.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
Message-ID: <CAHp75VdhHj-7Utganxo1YnSABmnM5KC+bVJe2KgXx65hNHNGng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
> This series adds name attribute to uart_port struct inorder to store
> name of the tty port that will help in identify different uart
> instances.
> This patch series is based on discussion here[1].

Please, use versioning for the series. This AFAIU should be v3, and
next (which is expecting based on comments) would be v4.

> [1] https://www.spinics.net/lists/arm-kernel/msg569188.html

-- 
With Best Regards,
Andy Shevchenko
