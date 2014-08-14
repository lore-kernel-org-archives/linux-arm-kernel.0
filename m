From: dyoung@redhat.com (Dave Young)
Date: Thu, 14 Aug 2014 17:26:38 +0800
Subject: [PATCH 1/7] efi: move noefi early param code out of x86 arch code
In-Reply-To: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
Message-ID: <20140814092638.GB6330@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I addressed several comments from Matt, Randy and Will in this post.

Also rewrote the patch for efi=noruntime with using a generic param handling
function.

CCed Xen and SGI people, removed rtc list in cc for [1-6]/7 patches

Thanks
Dave
