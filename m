From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jan 2017 11:08:20 +0100
Subject: [PATCH V6 3/5] OF: Add missing I/O range exception for
 indirect-IO devices
In-Reply-To: <645d40d8-0db6-1737-88f4-fd839933b2ea@huawei.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-4-git-send-email-yuanzhichang@hisilicon.com>
 <20170127220357.3lpavvyeymlhvlfg@rob-hp-laptop>
 <645d40d8-0db6-1737-88f4-fd839933b2ea@huawei.com>
Message-ID: <CAK8P3a1JhrNcoQkspBE4Kzw2ETPtWRLcPARiOQB3eWoUx=LaFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 9:57 AM, John Garry <john.garry@huawei.com> wrote:
> On 27/01/2017 22:03, Rob Herring wrote:
>> On Tue, Jan 24, 2017 at 03:05:23PM +0800, zhichang.yuan wrote:
>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>>
>> Shouldn't this be Reviewed-by?
>>
>
> The background is that Zhichang is following a sketch of a re-worked driver
> from Arnd, which Arnd gave Signed-off-by. But this patch does not follow it
> verbatim.
>
> I think this patchset should be resent without Arnd's signature. Or Arnd may
> kindly review and say it's ok.

My general recommendation is that whenever authorship  is not 100% obvious,
then the changelog comment should explain in free form who did what. When
you do that, please leave my Signed-off-by intact and put it on top.
You can also (in addition to explaining it in the text) add an
explanantion behind
the address, such as

Signed-off-by: Arnd Bergmann <arnd@arndb.de> # earlier draft

I'll try to get around to do a full review of the series later today.

    Arnd
