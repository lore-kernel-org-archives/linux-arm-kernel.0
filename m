From: girish.shivananjappa@linaro.org (Girish K S)
Date: Mon, 1 Jul 2013 20:34:38 +0530
Subject: [v2 4/4] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <20130701144817.GT13206@S2101-09.ap.freescale.net>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>
 <CAGxe1ZEHWQUXmjgmGGkpy3wgxoS8ti0-eYZPHkQKzjD9pWqZ0Q@mail.gmail.com>
 <20130701144817.GT13206@S2101-09.ap.freescale.net>
Message-ID: <CAGxe1ZEhTumWC5mpirjSqg2fogFz5VuLKLtxUpA=ctxdwU-i6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2013 20:18, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Jul 01, 2013 at 04:57:35PM +0530, Girish K S wrote:
>> Hello Richard,
>>
>> Instead of writing a separate driver for the changes you mentioned in
>> the commit message. you can just add those changes to
>> the platform data (pdata-> init).
>
> No. The platform init hook is not used to do IP block related setup.
> If we're mapping ahci block and setting up ahci registers in platform
> code, we are generally not doing the right thing.

Yes I understand (anything specific to driver should be part of
driver). I need to touch few platforms that are already doing this.
Then how about keeping setup as part of driver data for the specific controller.


>
> Shawn
>
