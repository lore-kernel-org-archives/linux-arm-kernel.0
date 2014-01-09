From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 9 Jan 2014 13:40:38 +0100
Subject: [PATCH v2 3/6] ARM: tegra: Add efuse bindings
In-Reply-To: <52CDD430.3010508@wwwdotorg.org>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
 <1387891931-9854-4-git-send-email-pdeschrijver@nvidia.com>
 <52CB14D3.2060904@wwwdotorg.org>
 <20140108133951.GD1592@ulmo.nvidia.com>
 <52CD9DFB.9010007@wwwdotorg.org>
 <20140108200946.GE1298@ulmo.nvidia.com>
 <52CDD430.3010508@wwwdotorg.org>
Message-ID: <20140109124038.GB23668@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 03:41:52PM -0700, Stephen Warren wrote:
> On 01/08/2014 01:09 PM, Thierry Reding wrote:
> > On Wed, Jan 08, 2014 at 11:50:35AM -0700, Stephen Warren wrote:
> >> On 01/08/2014 06:39 AM, Thierry Reding wrote:
> >>> On Mon, Jan 06, 2014 at 01:40:51PM -0700, Stephen Warren wrote:
> >>>> On 12/24/2013 06:32 AM, Peter De Schrijver wrote:
> >>> [...]
> >>>>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> >>>>
> >>>>> +	efuse at 7000F800 {
> >>>>
> >>>> "fuse" might be a better node name; "efuse" is presumably the name of
> >>>> the instance, not the type of object.
> >>>
> >>> There's another occurrence I noticed recently where we haven't followed
> >>> that rule. The PMIC node on Venice2 for instance is called as3722.
> >>> Perhaps that should also be renamed.
> >>
> >> Yes, we should fix that. Care to send a patch?
> > 
> > Ugh... I've just been going through some of the other DTS files and see
> > that quite a lot of other places aren't following this rule either. The
> ...
> > Perhaps it isn't worth fixing them all up after all?
> 
> I guess that just means the patch will be a little bigger; it doesn't
> seem like that's a good reason not to fix the issue.

Alright, I'll make a pass over all the DTS files that we have and try to
restore some consistency.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/8b8b37d4/attachment-0001.sig>
