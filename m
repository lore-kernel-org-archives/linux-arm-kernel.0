From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Dec 2015 09:18:42 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable TPS65217 regulator
In-Reply-To: <20151221102408.GA4339@afzalpc>
References: <1447225753-2788-1-git-send-email-afzal.mohd.ma@gmail.com>
 <20151220184453.GB32594@localhost> <20151221102408.GA4339@afzalpc>
Message-ID: <CAOesGMiA2+e2xNzuQyAXUkSHkGbTdGZMKF982=Py35wtxosECw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 21, 2015 at 2:24 AM, Afzal Mohammed <afzal.mohd.ma@gmail.com> wrote:
> Hi Olof,
>
> On Sun, Dec 20, 2015 at 10:44:53AM -0800, Olof Johansson wrote:
>> On Wed, Nov 11, 2015 at 12:39:13PM +0530, Afzal Mohammed wrote:
>
>> > Enable TPS65217 regulator to have rootfs in MMC for Beagle Bone's.
>> >
>> > Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>
>> > Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
>
>> Applied, thanks.
>
> Would it be possible to consider the similar patch [1] from Nishant
> Menon instead of this patch ?, though i am not satisfied with the
> changelog in his, i.e. regarding mention that it is required only for
> older Beagle Bones. He has sent the initial version of it (identical in
> diff) before mine.
>
> Sorry for the trouble and Thanks.

So the diff is the same, his is sent before yours but you're unhappy
with his commit message? Sounds like we're better off using yours, and
either way the code is the same.

I'll keep it the way it is -- it's not worth the work to rewind the
branch and break our downstream developers if there are any.


Regards,

-Olof
