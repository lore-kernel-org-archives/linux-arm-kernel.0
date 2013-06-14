From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 14 Jun 2013 12:53:08 +0800
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130613171144.GH18614@n2100.arm.linux.org.uk>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
 <20130613074551.GA7769@mudshark.cambridge.arm.com>
 <51B9DE5C.9030904@wwwdotorg.org>
 <20130613171144.GH18614@n2100.arm.linux.org.uk>
Message-ID: <CAMj5BkjY2_EeTFMnL=4aOUUeWjNHLu3MW5VAtXAuLT-HH7wxcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 1:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 13, 2013 at 08:59:40AM -0600, Stephen Warren wrote:
>> Russell, does this look good to you? I assume I should put this into the
>> ARM patch tracker.
>
> I think it's fine.  It would be nice if zhangfei gao would test these
> patches and confirm whether they fix it there as well.

It also works here, pass two hours stress test of panic -> reboot.

Tested-by:  Zhangfei Gao <zhangfei.gao@gmail.com>
