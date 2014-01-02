From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Jan 2014 09:11:08 +0100
Subject: [PATCH v3 3/5] ARM: dts: sun7i: external clock outputs
In-Reply-To: <CAGb2v66WrvasyFohuGhYvTPNHwh1VdUejMa8m8QTakg6BPG-uw@mail.gmail.com>
References: <1388543450-16741-1-git-send-email-wens@csie.org>
 <1388543450-16741-4-git-send-email-wens@csie.org>
 <20140101231039.GG3144@lukather>
 <CAGb2v66WrvasyFohuGhYvTPNHwh1VdUejMa8m8QTakg6BPG-uw@mail.gmail.com>
Message-ID: <20140102081108.GJ3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 10:41:23AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Jan 2, 2014 at 7:10 AM, Maxime Ripard
> > On Wed, Jan 01, 2014 at 10:30:48AM +0800, Chen-Yu Tsai wrote:
> >> This commit adds the two external clock outputs available on A20 to
> >> its device tree. A dummy fixed factor clock is also added to serve as
> >> the first input of the clock outputs, which according to AW's A20 user
> >> manual, is the 24MHz oscillator divided by 750.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > I'm ok with this patch, but I'll let Emilio and Mike give their
> > opinion on the driver before merging it.
> 
> The driver has not changed since v1.
> Mike merged it via Emilio's pull request.

Ah, right, I forgot about this.

I just merged this patch as well.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140102/968c0869/attachment.sig>
