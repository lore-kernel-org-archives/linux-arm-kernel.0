From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Dec 2017 13:23:11 +0000
Subject: [PATCH v3 00/20] arm64: Unmap the kernel whilst running in
 userspace (KPTI)
In-Reply-To: <2eda3880-4542-1572-f680-9aeb820abcef@redhat.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <2eda3880-4542-1572-f680-9aeb820abcef@redhat.com>
Message-ID: <20171211132311.GI26810@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 04:40:05PM -0800, Laura Abbott wrote:
> On 12/06/2017 04:35 AM, Will Deacon wrote:
> >Hi everybody,
> >
> >This is version three of the patches formerly known as KAISER (?).
> >
> >   v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/542751.html
> >   v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/544817.html
> >
> >Changes since v2 include:
> >
> >   * Rename command-line option from "kaiser=" to "kpti=" for parity with x86
> >   * Fixed Falkor erratum workaround (missing '~')
> >   * Moved vectors base from literal pool into separate data page
> >   * Added TTBR_ASID_MASK instead of open-coded constants
> >   * Added missing newline to error message
> >   * Fail to probe SPE if KPTI is enabled
> >   * Addressed minor review comments
> >   * Added tags
> >   * Based on -rc2
> >
> >Patches are also pushed here:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kpti
> >
> >Feedback and testing welcome. At this point, I'd like to start thinking
> >about getting this merged for 4.16.
> >
> 
> You can add
> 
> Tested-by: Laura Abbott <labbott@redhat.com>

Thanks, Laura!

Will
