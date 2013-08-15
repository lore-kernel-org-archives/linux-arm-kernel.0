From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 Aug 2013 13:13:52 +0200
Subject: [RFC PATCH] pwm: atmel-pwm: add pwm controller driver
In-Reply-To: <51D523FD.7040409@atmel.com>
References: <1371804355-8071-1-git-send-email-voice.shen@atmel.com>
 <51D523FD.7040409@atmel.com>
Message-ID: <20130815111351.GA14418@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 03:27:57PM +0800, Bo Shen wrote:
> Hi All,
> 
> On 6/21/2013 16:45, Bo Shen wrote:
> >add atmel pwm controller driver based on PWM framework
> >
> >this is basic function implementation of pwm controller
> >it can work with pwm based led and backlight
> >
> >Signed-off-by: Bo Shen <voice.shen@atmel.com>
> >---
> >  .../devicetree/bindings/pwm/atmel-pwm.txt          |   19 ++
> >  drivers/pwm/Kconfig                                |    9 +
> >  drivers/pwm/Makefile                               |    1 +
> >  drivers/pwm/pwm-atmel.c                            |  326 ++++++++++++++++++++
> >  4 files changed, 355 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> >  create mode 100644 drivers/pwm/pwm-atmel.c
> 
> Does this patch can be applied? If yes, I will send out the formal
> patch without RFC in subject. If no, please help review this patch
> and give your comments.

Hi,

Sorry I seem to have completely missed this. Can you please resend the
patch to my new email address and Cc linux-pwm at vger.kernel.org. That
will make sure that I see and can review it.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/ea7bd4ee/attachment.sig>
