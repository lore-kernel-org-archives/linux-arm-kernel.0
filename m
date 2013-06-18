From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Jun 2013 12:56:17 -0700
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <alpine.LFD.2.03.1306181528050.18597@syhkavp.arg>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130613203218.GA22310@quad.lixom.net>
 <alpine.LFD.2.03.1306131817310.18597@syhkavp.arg>
 <20130618172434.GI3289@localhost.localdomain>
 <alpine.LFD.2.03.1306181528050.18597@syhkavp.arg>
Message-ID: <CAOesGMiE4uRM01obQA584Neufws5K8HsarA0TVcx-2JmSdNgGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I agree with most of the thread so far, but just wanted to highlight this:

On Tue, Jun 18, 2013 at 12:50 PM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:

> Well... right now I think it is hard to abstract things properly as we
> have very few backends.  I would like to see more of them first.

Yes. This.

And this is why it's critical, absolutely critical, that the first one
or two implementations go in are as simple and clean as possible.

Otherwise seeing the commonalities and how to abstract them out will
be a complete headache, since only the person writing the driver will
be able to get a good grasp of it (alternatively, it will take a lot
of effort for someone to figure out, clean up, and see the bigger
picture).


-Olof
