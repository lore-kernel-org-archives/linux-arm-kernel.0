From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 25 Aug 2014 11:24:26 +0100
Subject: [PATCH 1/7] efi: move noefi early param code out of x86 arch code
In-Reply-To: <20140814092638.GB6330@darkstar.nay.redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
 <20140814092638.GB6330@darkstar.nay.redhat.com>
Message-ID: <20140825102426.GO29733@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Aug, at 05:26:38PM, Dave Young wrote:
> Hi,
> 
> I addressed several comments from Matt, Randy and Will in this post.
> 
> Also rewrote the patch for efi=noruntime with using a generic param handling
> function.
> 
> CCed Xen and SGI people, removed rtc list in cc for [1-6]/7 patches

Thanks Dave, I picked all of these patches up into the 'next' branch.

-- 
Matt Fleming, Intel Open Source Technology Center
