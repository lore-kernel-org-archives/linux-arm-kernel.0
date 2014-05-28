From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 28 May 2014 10:12:09 +0200
Subject: [PATCH v3 00/14] ARM/ARM64: KVM: big endian host support
In-Reply-To: <CAA3XUr2DHae55t7kXFYTv6-5wyBohoyOvs_tqA4kN7RFrfc=xw@mail.gmail.com>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <20140526154959.GD31431@lvm>
 <CAA3XUr2DHae55t7kXFYTv6-5wyBohoyOvs_tqA4kN7RFrfc=xw@mail.gmail.com>
Message-ID: <20140528081209.GI16428@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 11:31:08PM -0700, Victor Kamensky wrote:
> On 26 May 2014 08:49, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Tue, May 13, 2014 at 09:13:52AM -0700, Victor Kamensky wrote:
> >> Hi,
> >>
> >> Here is updated patches to address KVM host support in big endian
> >> ARM V7/V8.
> >>
> >> Changes since previous version [1] and [2]:
> >>
> >> x) joined both v7 [1] and v8 [2] series into one
> >>
> >> x) addressed, nearly all, Christoffer's comments to previous
> >> patch series
> >>
> >> x) Fixed few issues in 'ARM: KVM: handle 64bit values passed to
> >> mrcc or from mcrr instructions in BE case' that got discovered
> >> after moving to the latest v3.15-rc5 kernel
> >
> > What were the issues?
> 
> You correctly spotted it: it related TTBR handling and access_vm_reg
> function
> 
> >>
> >> x) Fixed issue in supporting 32bit guest by V8 BE KVM host
> >
> > Is this changes only from v2 to v3 or?
> 
> Change in v3 patch 14 that deals with access_vm_reg function.
> 
> > Consider using the common format for changelogs, see here for an
> > example:
> > https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009468.html
> 
> Thanks. Will try to do that.
> 
> Christoffer, Marc thank you very much  for review! I accepted a lot of
> comments and update patches. For remaining issues I've sent my
> responses. When we get a bit more closure on remaining issues, I
> will report the series.
> 
Thanks!
