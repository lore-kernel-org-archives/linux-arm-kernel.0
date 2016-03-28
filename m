From: panand@redhat.com (Pratyush Anand)
Date: Mon, 28 Mar 2016 19:41:36 +0530
Subject: [PATCH v14 3/4] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
In-Reply-To: <56F935AC.3020009@roeck-us.net>
References: <1456735610-22012-1-git-send-email-fu.wei@linaro.org>
 <1456735610-22012-4-git-send-email-fu.wei@linaro.org>
 <CADyBb7shY-A-DTKEvNQS71SUtNmE6tkURfWDEb-_9eB-4htGWA@mail.gmail.com>
 <56F935AC.3020009@roeck-us.net>
Message-ID: <20160328141136.GA13855@dhcppc0.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/03/2016:06:46:20 AM, Guenter Roeck wrote:
> On 03/28/2016 06:12 AM, Fu Wei wrote:
> >Hi Wim, Guenter:
> >
> >Great thanks for reviewing and applying this patchset :-)
> >Now I can see almost all the patches of this patchset have been merged
> >into the master branch of mainline kernel.
> >But only this one is still out of any branch or repo. It seems that
> >it's applied on linux-watchdog for a while, then disappeared.
> >
> >
> >So any thing I can do for this patch? Do I need to resubmit it?
> >Maybe I miss it in some repo? Could you help me ?
> >Great thanks ! :-)
> >
> 
> If I recall correctly, it was supposed to go in through some other tree (arm-soc ?)

Yes, it should have gone through arm-soc tree. But, it seems it got missed.  The
other dt patch for foundation-v8 is there in v4.6 pull request
[https://lkml.org/lkml/2016/3/20/244].

~Pratyush
