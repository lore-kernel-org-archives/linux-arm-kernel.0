From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 19 May 2015 22:41:09 +0800
Subject: [PATCH v2] spi: sirf: add support for USP-based SPI
In-Reply-To: <20150519112201.GH2761@sirena.org.uk>
References: <1431602829-12428-1-git-send-email-21cnbao@gmail.com>
 <20150519112201.GH2761@sirena.org.uk>
Message-ID: <CAGsJ_4yTm_JE36iGNxw5sk4BaugfmwMLQQUFPX_kQrTamkX91Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-19 19:22 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Thu, May 14, 2015 at 11:27:09AM +0000, Barry Song wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>
>> USP is a general purpose serial port in SiRFSoC, which can work as SPI.
>> the most data flow of USP and pure SPI is same with main differences
>> in registers layout.
>
> This doesn't apply against current code, please check and resend.

sorry.
i made a big mis-operation. right now i sent a new version to fix it.

-barry
