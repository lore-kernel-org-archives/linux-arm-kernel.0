From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 21 Jun 2017 17:36:32 +0200
Subject: [RFC PATCH v3 3/6] ARM/arm64: dts: enable wakeup for cros-ec-spi
 devices
In-Reply-To: <594A91C9.1090906@rock-chips.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
 <1498039313-24220-4-git-send-email-jeffy.chen@rock-chips.com>
 <CAJKOXPdL2CB9VWNo=it0dos-4hJYrgHUSZwcG1DS=9c+YxXzhQ@mail.gmail.com>
 <594A91C9.1090906@rock-chips.com>
Message-ID: <20170621153632.7cajs5xwdmhdm2fg@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 11:33:29PM +0800, jeffy wrote:
> Hi Krzysztof,
> 
> thanx for your comment.
> 
> On 06/21/2017 06:45 PM, Krzysztof Kozlowski wrote:
> > On Wed, Jun 21, 2017 at 12:01 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> > > We used to enable wakeup for cros-ec-spi devices unconditionally.
> > > Now we are using the more generic wakeup-source property to enable it.
> > 
> > Using wakeup-source property is still enabling this unconditionally.
> > What  do you exactly mean here?
> i mean the wakeup-source is an optional property, we can disable wakeup by
> not adding it.

Maybe mention this in commit msg? This removes any confusion. "Till now
the driver always enabled wakeup but now it supports wakeup property so
add it to keep same functionality."

Best regards,
Krzysztof
