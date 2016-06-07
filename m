From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 07 Jun 2016 21:48:42 +0800
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <20160607133247.GY7510@sirena.org.uk>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk> <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk> <5756B22F.9000105@rock-chips.com>
 <20160607120647.GV7510@sirena.org.uk> <5756C245.7010001@rock-chips.com>
 <20160607133247.GY7510@sirena.org.uk>
Message-ID: <5756D0BA.7060702@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2016?06?07? 21:32, Mark Brown wrote:
> On Tue, Jun 07, 2016 at 08:47:01PM +0800, Xing Zheng wrote:
>> On 2016?06?07? 20:06, Mark Brown wrote:
>>> OK, then the original name probably makes some sense though really
>>> that's such an unusual design that just naming it after the specific
>>> board might be better, it's not likely to see any reuse I'd guess.
>> There are not only one type of board with this audio connection, so I think
>> we don't need to add specific board name.
> I imagine they're all variants on a single reference design though?  The
> name is unweildy.
Yes, they are based on a single reference design which is called gru, so 
could I use the name "rk3399-gru-sound"?

Thanks.

-- 
- Xing Zheng
