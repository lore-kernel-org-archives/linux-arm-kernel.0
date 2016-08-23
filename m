From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2016 12:30:54 +0100
Subject: [PATCH] mm, numa: boot cpu should bound to the node0 when
 node_off enable
In-Reply-To: <57BC3125.7090003@huawei.com>
References: <1471525766-12803-1-git-send-email-zhongjiang@huawei.com>
 <20160818160437.GA21343@e104818-lin.cambridge.arm.com>
 <CAFpQJXUYxPsTArMkv27r2u19v92APjjNF5W0bMNqQKGqNUin5g@mail.gmail.com>
 <57B667CA.5060905@huawei.com>
 <CAFpQJXVzr0uvV00vtQkrAxzezW=QRpL9EKPL+4yqhmKE5GdXKA@mail.gmail.com>
 <CAFpQJXXXAhQQxr9=SmW2-bHmAYQMyn93zFiYZiBqbjgyZg2oJw@mail.gmail.com>
 <57B82533.9010507@huawei.com>
 <20160822142833.GE26494@e104818-lin.cambridge.arm.com>
 <57BC3125.7090003@huawei.com>
Message-ID: <20160823113054.GC28945@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 07:19:01PM +0800, Leizhen (ThunderTown) wrote:
> He applied my patches, which I mentioned these days.

[...]

> I will update my patch series and resend it again.

To be clear, you plan to send an updated version of:

  [PATCH v6 00/14] fix some type infos and bugs for arm64/of numa

so I can ignore v6 of that?

Will
