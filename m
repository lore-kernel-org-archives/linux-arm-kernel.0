From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 28 Sep 2017 11:36:24 -0700
Subject: [PATCH 4/8] ARM: dts: aspeed-romulus: Add I2C devices
In-Reply-To: <20170928075149.8154-5-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-5-joel@jms.id.au>
Message-ID: <CAFd5g46bGnA4dkOc3-VNzRwt36wp2Er7OeVPeNbqHBBVBgmxaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 12:51 AM, Joel Stanley <joel@jms.id.au> wrote:
> Enable the buses that are in use and the devices that are attached.
> Currently that is just the battery backed RTC.
>
> Some of these buses are for hotplugged cards, such as PCIe cards. Others
> do not yet have upstream drivers, so there are no devices attached.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
