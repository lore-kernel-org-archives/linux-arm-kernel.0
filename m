From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 6 May 2011 20:43:39 +0200
Subject: [RFC/PATCH] OMAP PM: remove OMAP_PM_NONE config option
In-Reply-To: <alpine.DEB.2.00.1105061016070.30136@utopia.booyaka.com>
References: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1105061016070.30136@utopia.booyaka.com>
Message-ID: <BANLkTimgrpKq_SrD=U9rzXspKv8eOcsv0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, May 6, 2011 at 6:16 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Salut Jean
>
> On Fri, 6 May 2011, Jean Pihet wrote:
>
>> The current code base is not linking with the OMAP_PM_NONE
>> option set.
>> Since the option OMAP_PM_NOOP provides a no-op/debug layer,
>> OMAP_PM_NONE can be removed.
>> OMAP_PM_NOOP is enabled by default by Kconfig.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> I'm okay with this but could you please base it on v2.6.39-rc6 so I can
> merge it here?
I checked the patch against the master branch of both Tony's and
Linus's trees, it applies and compiles OK.
Is that OK to you?

Regards,
Jean

>
> thanks
>
>
> - Paul
>
