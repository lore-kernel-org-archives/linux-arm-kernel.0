From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 27 Sep 2012 17:00:01 +0200
Subject: [PATCH v4 2/2] ARM: at91: add at91sam9_wdt driver to at91sam926x,
 at91sam9g45
In-Reply-To: <20120927055021.GO17667@game.jcrosoft.org>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
 <1348568704-28304-3-git-send-email-fabio.porcedda@gmail.com>
 <20120927055021.GO17667@game.jcrosoft.org>
Message-ID: <CAHkwnC-76qUZaKHA7O5rdMDCAbDB52b9UL9hKWWiTBFQHpUS0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 7:50 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 12:25 Tue 25 Sep     , Fabio Porcedda wrote:
>> Enable the driver for the evk-pro3 board.
>>
>> Tested on an at91sam9260 board (evk-pro3).
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> ---
>>  arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
>>  arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
>>  arch/arm/boot/dts/at91sam9g45.dtsi | 6 ++++++
>>  arch/arm/boot/dts/evk-pro3.dts     | 4 ++++
> split board and soc

Ok, i will send an updated patch.

> Best Regards,
> J.

Best regards
-- 
Fabio Porcedda
