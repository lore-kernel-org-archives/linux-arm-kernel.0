From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 5 Sep 2014 15:57:45 +0800
Subject: [PATCH 6/8] spi: sirf: set default spi frequency if it is not set
In-Reply-To: <20140904223913.GU29327@sirena.org.uk>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-2-git-send-email-Barry.Song@csr.com>
 <20140904223913.GU29327@sirena.org.uk>
Message-ID: <CAGsJ_4xwsKwVJ4psBtf9pRaxFxw4k95fWLjbr+3zMck-6jfe8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-05 6:39 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Tue, Sep 02, 2014 at 05:02:35PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>

sorry, this patch actually has no effect now as it is outdated.

>> give spi a default frequence if it is not set and the value is 0.
>
> I think this is a good idea but I think we should do this in the SPI
> core rather than this driver since the same thing is going to apply to
> many drivers.  Can you do a patch for that?
>

this has been done by commit 052eb2d49,  sorry for making noise.

-barry
