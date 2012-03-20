From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Mar 2012 16:44:52 +0100
Subject: [PATCH v4 07/10] pwm: tegra: Add device tree support
In-Reply-To: <4F68A32D.1000402@wwwdotorg.org>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-8-git-send-email-thierry.reding@avionic-design.de>
 <4F67EE9A.6080101@wwwdotorg.org>
 <20120320084807.GC20249@avionic-0098.adnet.avionic-design.de>
 <4F68A32D.1000402@wwwdotorg.org>
Message-ID: <20120320154452.GB8651@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/20/2012 02:48 AM, Thierry Reding wrote:
> > * Stephen Warren wrote:
> >> On 03/14/2012 09:56 AM, Thierry Reding wrote:
> >>> Add auxdata to instantiate the PWFM controller from a device tree,
> >>> include the corresponding nodes in the dtsi files for Tegra 20 and
> >>> Tegra 30 and add binding documentation.
> >>>
> >>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >>
> >>> +++ b/Documentation/devicetree/bindings/pwm/tegra-pwm.txt
> >>
> >> Can this please be named nvidia,tegra20-pwm.txt so that if we need
> >> different bindings for any future Tegra PWM, we won't have any filename
> >> conflicts?
> > 
> > That file already documents the bindings for Tegra 20 and Tegra 30, that's
> > why I chose the move generic name. Could this perhaps be documented within
> > the file instead? Or should I rather add a nvidia,tegra30-pwm.txt with a
> > reference to the nvidia,tegra20-pwm.txt?
> 
> I think it's fine for a file of name nvidia,tegra20-pwm.txt to document
> both Tegra20 and Tegra30; the file is named after the first/earliest
> compatible value it documents. The issue is more that /if/ say TegraNN
> needs a different binding, I want the naming consistent (e.g.
> nvidia,tegraNN-pwm.txt) rather than having the old file with one style
> and the new file named using a different style.

Understood. I'll rename it for the next version.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/acc4ba5e/attachment.sig>
