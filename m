From: zonque@gmail.com (Daniel Mack)
Date: Sun, 11 Aug 2013 13:53:10 +0200
Subject: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Message-ID: <52077B26.1010103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thanks a lot for your work on this.

On 06.08.2013 19:49, Dave Gerlach wrote:
> This is the third version of the patch series for adding basic suspend-resume
> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset 
> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are 
> required for the pm code to properly suspend and resume.

I applied your set and the one from Suman Anna, and with musb disabled
and the firmware built from the sources you referenced, I'm able to put
a custom AM33xx based board to suspend.

The problem I currently face is that I can't make the board resume, as
neither UART0 nor GPIO0 seem to work as wakeup source.

Which wakeup source did you use in your tests?


Thanks,
Daniel
