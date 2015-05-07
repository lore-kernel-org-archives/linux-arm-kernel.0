From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 7 May 2015 18:00:25 +0800
Subject: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
In-Reply-To: <20150507094639.GJ22845@sirena.org.uk>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
 <20150507094639.GJ22845@sirena.org.uk>
Message-ID: <CAGsJ_4ztxLPvbkg8MZJYSKAdu=zeCgGqOSMZo2q4bZkaZjMiyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-07 17:46 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Thu, May 07, 2015 at 07:13:10AM +0000, Barry Song wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>
>
> Applied since it's an improvement but please do update to use the core
> features like Geert suggested.

it looks like a good idea from Geert. we will have an incremental
patch for this.

-barry
