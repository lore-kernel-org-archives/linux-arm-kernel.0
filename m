From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 15 Oct 2015 14:42:12 +0200
Subject: [GIT PULL 2/3] ARM: berlin: DT changes for v4.4 (round 1)
In-Reply-To: <6053924.4novCdxIMG@wuerfel>
References: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1444416494-3117-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <6053924.4novCdxIMG@wuerfel>
Message-ID: <561F9F24.1050801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.10.2015 17:44, Arnd Bergmann wrote:
> On Friday 09 October 2015 20:48:13 Sebastian Hesselbarth wrote:
>> this is round 1 of Marvell Berlin DT changes for v4.4. There is
>> some improvement in serial aliases/stdout path, cpufreq properties,
>> and PWM nodes for all SoCs. The cpufreq properties depend on cpuclk
>> being available, therefore this branch has a dependency with the
>> cpuclk topic PR sent earlier.
>>
>
> Pulled into next/dt, thanks!

Hi Arnd,

the prerequisite cpuclk topic branch didn't make it into arm-soc causing
a build failure on bg2q dts files.

Unfortunately, cpuclk topic branch touches both, dt-includes and driver
code. I was hoping you could also pull the topic branch with berlin/dt.

I am open for suggestions how to deal with it now and in the future.

Sebastian
