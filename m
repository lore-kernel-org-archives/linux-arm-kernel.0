From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 28 Sep 2017 11:36:56 -0700
Subject: [PATCH 5/8] ARM: dts: aspeed-palmetto: Add I2C devices
In-Reply-To: <20170928075149.8154-6-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-6-joel@jms.id.au>
Message-ID: <CAFd5g47p06pj59EcU0xJMAG_F=gf4RRNvab32GrB9ZocaOzxEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 12:51 AM, Joel Stanley <joel@jms.id.au> wrote:
> Enable the buses that are in use and the devices that are attached.
> Currently that includes the battery backed RTC, temperature measurement
> and EEPROM.
>
> Some of these buses are for hotplugged cards, such as PCIe cards.
> Others do not yet have upstream drivers, so there are no devices
> attached.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
