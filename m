From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jun 2017 16:28:41 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.13 (#2)
In-Reply-To: <87wp82yeng.fsf@free-electrons.com>
References: <877f041a4p.fsf@free-electrons.com>
 <CAK8P3a3UuLFVxZv1o1+gKSafsGgV=vgWRM_yjnT_E4fAUPZx8g@mail.gmail.com>
 <87wp82yeng.fsf@free-electrons.com>
Message-ID: <CAK8P3a1awsqu5eN4eMPMmiZ-JXn64wA+y-LUR0EdHjYiCRK+Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 4:14 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Arnd,
>
>  On ven., juin 23 2017, Arnd Bergmann <arnd@arndb.de> wrote:
>
>
>>
>>
>> Please send a revert for that, and remove the code that tries to
>> parse the dma-mask from DT from that driver!
>
> I see on IRC you agree with Antoine about it the driver part. For the DT
> part do you want a PR with the revert or just the patch alone?

Either way is fine, or just let me know (here or on IRC) if I should
just revert the patch and add an explanation myself.

       Arnd
