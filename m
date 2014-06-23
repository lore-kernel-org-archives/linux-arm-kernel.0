From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Jun 2014 13:34:21 -0500
Subject: [PATCH for v3.15] usb: musb: Fix panic upon musb_am335x module
 removal
In-Reply-To: <CAAEAJfAH6V9BQH2adJq-FKAYrcDrw4x5Uc7S0nudL7cuJZzD0w@mail.gmail.com>
References: <1400371473-2053-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <20140520165510.GA28859@arch.cereza>
 <20140614125902.GA1202@arch.cereza>
 <20140623182300.GC5073@saruman.home>
 <CAAEAJfAH6V9BQH2adJq-FKAYrcDrw4x5Uc7S0nudL7cuJZzD0w@mail.gmail.com>
Message-ID: <20140623183421.GE5073@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:29:07PM -0300, Ezequiel Garc?a wrote:
> On 23 June 2014 15:23, Felipe Balbi <balbi@ti.com> wrote:
> 
> >>
> >> Any comments on this? I don't like to remove a feature, but as
> >> explained above, I don't see any other way to solve this.
> >>
> >> The driver is currently broken. I tried using of_platform_depopulate()
> >> but failed.
> >
> > yeah, I know about the problem and, frankly, there's no other way to fix
> > this. Just resend with linux-usb in Cc.
> >
> 
> Ouch, forgot about linux-usb on this one! I'm resending on top of
> v3.16-rc1 (although I think this one already applies).

thanks, that helps

> Thanks for the feedback,

no problem.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/30d92a7b/attachment.sig>
