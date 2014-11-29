From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 29 Nov 2014 17:20:53 +0100
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <87ppcaknpx.fsf@linaro.org>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA9P6aX+mh3rEMy=Z7SKF=kRrxgYefLwFcrk806QQpwiuQ@mail.gmail.com>
 <87ppcaknpx.fsf@linaro.org>
Message-ID: <20141129162053.GD23653@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 03:04:10PM +0000, Alex Benn?e wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 25 November 2014 at 16:10, Alex Benn?e <alex.bennee@linaro.org> wrote:
> >> +/* Exit types which define why we did a debug exit */
> >> +#define KVM_DEBUG_EXIT_ERROR           0x0
> >> +#define KVM_DEBUG_EXIT_SINGLE_STEP     0x1
> >> +#define KVM_DEBUG_EXIT_SW_BKPT         0x2
> >> +#define KVM_DEBUG_EXIT_HW_BKPT         0x3
> >> +#define KVM_DEBUG_EXIT_HW_WTPT         0x4
> >
> > The names of these imply that they're generic, but they're
> > defined in an arch-specific header file...
> 
> Yeah, I think these will die and I'll just export the syndrome
> information directly to QEMU.

huh?

-Christoffer
