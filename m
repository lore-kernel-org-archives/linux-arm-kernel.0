From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 27 Aug 2011 17:53:26 +0800
Subject: [PATCH v2 2/4] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <20110823094152.GD19622@n2100.arm.linux.org.uk>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-3-git-send-email-Baohua.Song@csr.com>
	<20110823094152.GD19622@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4yCfpDZVkExXDkhQMnZVcwdjV6jtOTYXkyGHH9pTCWtxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Aug 22, 2011 at 11:15:50PM -0700, Barry Song wrote:
>> From: Rongjun Ying <rongjun.ying@csr.com>
>>
>> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>> ?-v2:
>> ?delete redundant ARM mode registers save/restore
>> ?use generic cpu suspend
>> ?move l2 cache suspend/resume codes out
>> ?make memc become a device driver

Arnd, are you ok with this or you have more comments? if you have been
ok, i'd like to send v3 with fixing comments from Jamie, Shawn and
you.

-barry
