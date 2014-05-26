From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 26 May 2014 17:49:59 +0200
Subject: [PATCH v3 00/14] ARM/ARM64: KVM: big endian host support
In-Reply-To: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140526154959.GD31431@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:13:52AM -0700, Victor Kamensky wrote:
> Hi,
> 
> Here is updated patches to address KVM host support in big endian
> ARM V7/V8.
> 
> Changes since previous version [1] and [2]:
> 
> x) joined both v7 [1] and v8 [2] series into one
> 
> x) addressed, nearly all, Christoffer's comments to previous
> patch series
> 
> x) Fixed few issues in 'ARM: KVM: handle 64bit values passed to
> mrcc or from mcrr instructions in BE case' that got discovered
> after moving to the latest v3.15-rc5 kernel

What were the issues?

> 
> x) Fixed issue in supporting 32bit guest by V8 BE KVM host

Is this changes only from v2 to v3 or?

Consider using the common format for changelogs, see here for an
example:
https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009468.html

Thanks,
-Christoffer
