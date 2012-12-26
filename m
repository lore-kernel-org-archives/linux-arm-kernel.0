From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 26 Dec 2012 20:09:05 +0300
Subject: [PATCH 2/2] spi: sirf: add support for new SiRFmarco SMP SoC
In-Reply-To: <CAGsJ_4wp1KvfotmDHzTCU9bmEP5BKDAU=Z0qjvOXw6FoFYNNKQ@mail.gmail.com>
References: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
 <1356490114-18022-2-git-send-email-Barry.Song@csr.com>
 <50DAE219.10806@mvista.com>
 <CAGsJ_4wp1KvfotmDHzTCU9bmEP5BKDAU=Z0qjvOXw6FoFYNNKQ@mail.gmail.com>
Message-ID: <50DB2F31.1000300@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/26/2012 03:32 PM, Barry Song wrote:

>>> From: Barry Song <Baohua.Song@csr.com>

>>> the driver is also compatible with SiRFmarco except SiRFprimaII,
>>> so simply add "sirf,marco-spi" to OF match table.

>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>

>>     You've just posted this patch as a part of another 2-patch series.

> no, this one is spi, the other one is i2c.

   Sorry for the noise -- I was being blind (and goggles didn't help :-).

> -barry

WBR, Sergei
