From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Nov 2017 19:37:09 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <c09d26b4-2612-fb2e-fb95-897c937793ec@redhat.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <c09d26b4-2612-fb2e-fb95-897c937793ec@redhat.com>
Message-ID: <20171122193709.GK22648@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 02:50:58PM -0800, Laura Abbott wrote:
> On 11/17/2017 10:21 AM, Will Deacon wrote:
> >This patch series implements something along the lines of KAISER for arm64:
> 
> Passed some basic tests on Hikey Android and my Mustang box. I'll
> leave the Mustang building kernels for a few days. You're welcome
> to add Tested-by or I can re-test on v2.

Cheers, Laura. I've got a few changes for v2 based on Ard's feedback, so if
you could retest that when I post it then it would be much appreciated.

Will
