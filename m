From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 6 Oct 2015 20:26:22 -0600
Subject: [PATCH] ARM: bcm2835: add label for uart0
In-Reply-To: <87oagbhdfb.fsf@eliezer.anholt.net>
References: <1443810675-25558-1-git-send-email-stefan.wahren@i2se.com>
 <87oagbhdfb.fsf@eliezer.anholt.net>
Message-ID: <561482CE.2020804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2015 03:53 PM, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
>> This patch adds a label for uart0 to allow changing of uart0
>> pins.
>> 
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> This patch seems innocuous, but could you clarify for me how
> exactly you change the uart0 pins, and why one would do that?

I /assume/ this is so that some other DT file (that includes the
edited file) can add some pinctrl-related properties to this DT node,
using syntax such as:

&uart0 {
    new content;
};

If so, the patch,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
