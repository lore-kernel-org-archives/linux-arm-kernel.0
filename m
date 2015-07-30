From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Jul 2015 12:12:42 +0200
Subject: [PATCH 6/7] ARM: sun9i: Add clock indices
In-Reply-To: <CAGb2v65o8wh50u4pWuArspq+Bi=33JGp0TDF_N+hWZqHcRn4qQ@mail.gmail.com>
References: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
 <1437945270-32014-7-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65o8wh50u4pWuArspq+Bi=33JGp0TDF_N+hWZqHcRn4qQ@mail.gmail.com>
Message-ID: <20150730101242.GK2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 03:44:59PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 27, 2015 at 5:14 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A80 gates have a non continuous set of clock IDs that are valid. Add
> > the clock-indices property to the DT to express this.
> 
> The commit message does not match the patch, which is just a reformatting of
> existing clock-indices properties.

Indeed... That's what happens when you automate too much things.. :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150730/0b629f79/attachment.sig>
