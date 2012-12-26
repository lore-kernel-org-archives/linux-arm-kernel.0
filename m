From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 26 Dec 2012 20:32:55 +0800
Subject: [PATCH 2/2] spi: sirf: add support for new SiRFmarco SMP SoC
In-Reply-To: <50DAE219.10806@mvista.com>
References: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
 <1356490114-18022-2-git-send-email-Barry.Song@csr.com>
 <50DAE219.10806@mvista.com>
Message-ID: <CAGsJ_4wp1KvfotmDHzTCU9bmEP5BKDAU=Z0qjvOXw6FoFYNNKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/12/26, Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
> On 26-12-2012 6:48, Barry Song wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>
>> the driver is also compatible with SiRFmarco except SiRFprimaII,
>> so simply add "sirf,marco-spi" to OF match table.
>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
>     You've just posted this patch as a part of another 2-patch series.

no, this one is spi, the other one is i2c.

> WBR, Sergei

-barry
