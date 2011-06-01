From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Jun 2011 13:00:38 -0700
Subject: [PATCH 1/5] CPUFREQ/S3C64xx: Move S3C64xx CPUfreq driver into
	drivers/cpufreq
In-Reply-To: <20110601095811.GB13591@opensource.wolfsonmicro.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>	<BANLkTinR_WLjsgm5ogt_BbJwPFC0Kc1Dqg@mail.gmail.com>
	<20110601095811.GB13591@opensource.wolfsonmicro.com>
Message-ID: <4DE69A66.9090002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/11 02:58, Mark Brown wrote:
> On Wed, Jun 01, 2011 at 06:55:05PM +0900, Kyungmin Park wrote:
>
>> Instead of samsung tree, it should be handled at cpufreq tree.
>> CCed the cpufreq maintainer.
>
> Well, it's a something for both really as both trees are updated.  I
> sent the orginal copy of this patch to both places but both sets of
> maintainers just ignored it (I've never seen any response from the
> cpufreq maintainers on this driver ever since I originally submitted
> it).
>
Hi Mark,

Sorry for late response.
Basically, you're moving is great to me and will review in 1 day.

As I remember, 800Mhz support on S3C6410 is ok and replied about that.
Then isn't there any progress in my side?...I'm outside of my office.

> At the minute I'm mostly just trying to get some of the backlog of
> S3C64xx patches I'm accumilating out of my queue :(

Dave, I'd like to talk about moving Samsung cpufreq drivers. I sent
about Kconfig.arm. If you're ok, will submit remained one to move
all of Samsung cpufreq drivers. And if possible would be better to me,
if someone(you or me) could make some branch to merge into both.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
