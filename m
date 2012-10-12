From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Oct 2012 14:14:21 +0900
Subject: [PATCH] i2c: change the id to let the i2c device work
In-Reply-To: <5077A33E.4080801@atmel.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
 <20121012044042.GI11726@opensource.wolfsonmicro.com>
 <5077A33E.4080801@atmel.com>
Message-ID: <20121012051419.GJ11726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 12:57:34PM +0800, Bo Shen wrote:
> On 10/12/2012 12:40, Mark Brown wrote:
> >On Fri, Oct 12, 2012 at 10:34:18AM +0800, Bo Shen wrote:

> >>As the old method will use platform device id, change the id to
> >>let the i2c device work

> >What are "the old method" and new method?  You're not explaining why
> >this is needed...

> Maybe use the 'legacy method' will be better (I am not sure). Now,
> the Linux kernel is transferring to device tree which doesn't use
> platform device id. So, change the id to let the legacy code work.

> May you understand.

No, this still makes no sense to me.  This is clearly a non-DT device
registration, what does DT have to do with anything here?  What is the
practical problem you are seeing in your system and how does this help
with it?
