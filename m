From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 27 Jun 2013 19:50:37 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Remove combiner_init declaration
In-Reply-To: <201306261602.26800.arnd@arndb.de>
References: <1372246597-32323-1-git-send-email-sachin.kamat@linaro.org>
 <201306261602.26800.arnd@arndb.de>
Message-ID: <CAK9yfHx2sQ38xHDM0CyS_+0HP_gLq+XnaJf5PNyLbOFM_LbR+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2013 19:32, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 26 June 2013, Sachin Kamat wrote:
>> Commit d243997f ("ARM: EXYNOS: Remove legacy interrupt initialization
>> code") removed the call to combiner_init(). Since there are no more
>> users in the machine code, remove the declaration as well.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Hi,
>
> Your two patches look good to me, but I think there is more that
> can be cleaned up now. See below for my experimental patch.
> I have not gotten around to test or submit that, but feel
> free to take any contents for your own patches.

Thanks Arnd. Let me look into it.

-- 
With warm regards,
Sachin
