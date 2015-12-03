From: panand@redhat.com (Pratyush Anand)
Date: Thu, 3 Dec 2015 11:39:01 +0530
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <1449096562.6139.74.camel@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <002101d12c66$ae985440$0bc8fcc0$@codeaurora.org>
 <1449096562.6139.74.camel@infradead.org>
Message-ID: <20151203060901.GH14143@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 02/12/2015:02:49:22 PM, Geoff Levand wrote:
> Azriel and Pratyush,
> 
> On Tue, 2015-12-01 at 11:32 -0700, Azriel Samson wrote:
> > I tested with v11 on our platform and I too needed the invalidation
> > fix.
> 
> I pushed out a kexec-v12.1 branch to my linux-kexec repo [1] with
> fixes.  Could you test it with both kexec reboot and kdump?  For
> kdump, use something like:

I tested kexec-v12.1 with mustang and it works for both kexec and kdump.

There had been few updates with Akashi, which are not there in kexec-v12.1.
Please take his updates and merge them in v13.

~Pratyush
