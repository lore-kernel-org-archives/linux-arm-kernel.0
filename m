From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Feb 2017 09:05:26 -0200
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <13787b59-6bfc-d020-9853-ae37074009dc@i2se.com>
References: <6d3e9733-bebc-4347-95db-2a1c9018948d@i2se.com>
 <13787b59-6bfc-d020-9853-ae37074009dc@i2se.com>
Message-ID: <CAOMZO5BZ2=pvtscV4J52Tj8Gc3A-O5B4azzzQAr48mKJ_L8-tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Mon, Feb 6, 2017 at 8:49 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

>> Btw are Arnd and Olof informed about this urgent patch?
>
> @Shawn
>
> Okay, 4.10-rc7 is out but this fix isn't applied :-(
>
> Is there a chance for 4.10 or do we have to wait for 4.10.1?
>
> Maybe the subject of the patch is to harmless.

The patch is in the arm-soc 'fixes' branch:
https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=fixes&id=a971c5545c3d45a1e33fda6e57913bb75aaa20c9

Olof/Arnd,

Will this branch be sent to Linus so that it lands at 4.10 final?

Thanks
