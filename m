From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 17 Aug 2011 13:25:48 +0300
Subject: [PATCH] ARM: SAMSUNG: Modify the devname for pl330 clock
In-Reply-To: <001601cc5cba$27b49400$771dbc00$%kim@samsung.com>
References: <1313540801-12054-1-git-send-email-boojin.kim@samsung.com>
	<4E4B5CD9.7060703@mleia.com>
	<001601cc5cba$27b49400$771dbc00$%kim@samsung.com>
Message-ID: <CAMW3pwZXtDba6DsU5C-oLCcMLyXVaJQmLbzsvEwG97pO6YmdrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 17, 2011 at 11:46 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> Vladimir Zapolskiy wrote:
>> Hi,
>>
>> looks like it contains my series as a subset.
>
> As I replied on your patches, yes, I know that. I sent it before see your
> patch.
> Do you add the missing about s5p64x0 in your patch?
> If not, I will split up this patch to get missing about s5p64x0 in your
> patch.

No, I haven't added that. In my opinion it would be nice, if you can
split the patch and fix more incorrespondent device names for s5p64x0,
or probably it might be done at once replacing my version of the
change for s5p64x0 only.

Thank you a lot!

--
With best wishes,
Vladimir
