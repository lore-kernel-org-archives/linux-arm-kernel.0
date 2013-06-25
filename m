From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 26 Jun 2013 00:17:24 +0800
Subject: [PATCH] spi: sirf: add missed spi mode_bits that SiRFSoC hardware
 supports
In-Reply-To: <20130625154020.GG27646@sirena.org.uk>
References: <1372160729-12796-1-git-send-email-Baohua.Song@csr.com>
 <20130625154020.GG27646@sirena.org.uk>
Message-ID: <CAGsJ_4zztqXECjKJVQA955Dw=Qp3n4iFrbvQH-kd7s_4wpvvhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/25 Mark Brown <broonie@kernel.org>:
> On Tue, Jun 25, 2013 at 07:45:29PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>
>> Missing this will cause some user cases fail when they want to change spi
>> transfer mode.
>
> This doesn't seem to apply against the current SPI code or mainline -
> can you please check and resend?

this was againest your for-next branch of spi as i guessed it will be
in the coming version. you want one againest mainline?

-barry
