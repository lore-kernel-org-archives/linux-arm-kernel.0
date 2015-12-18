From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 18 Dec 2015 16:49:44 +0300
Subject: [PATCH v6 13/20] arm64: ilp32: share aarch32 syscall wrappers to
 ilp32
In-Reply-To: <mvm1tal3ztz.fsf@hawking.suse.de>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-14-git-send-email-ynorov@caviumnetworks.com>
 <mvm1tal3ztz.fsf@hawking.suse.de>
Message-ID: <20151218134944.GB31200@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 03:38:16PM +0100, Andreas Schwab wrote:
> Yury Norov <ynorov@caviumnetworks.com> writes:
> 
> > From: Jan Dakinevich <jan.dakinevich@gmail.com>
> >
> > statfs64, fstat64 and mmap_pgoff has wrappers that needed both by aarch32 and
> 
> Typo: s/fstat64/fstatfs64/
> 
> Andreas.

Thank you.
