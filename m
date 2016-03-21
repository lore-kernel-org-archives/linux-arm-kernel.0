From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 21 Mar 2016 15:17:00 +0000
Subject: [Xen-devel] [PATCH v2 0/5] xen: avoid module usage in non-modular
 code
In-Reply-To: <20160320002321.GX23251@windriver.com>
References: <1456099568-5154-1-git-send-email-paul.gortmaker@windriver.com>
 <20160320002321.GX23251@windriver.com>
Message-ID: <56F0106C.3030200@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/16 00:23, Paul Gortmaker wrote:
> [[PATCH v2 0/5] xen: avoid module usage in non-modular code] On 21/02/2016 (Sun 19:06) Paul Gortmaker wrote:
> 
>> This series of commits is a part of a larger project to ensure
>> people don't reference modular support functions in non-modular
>> code.  Overall there was roughly 5k lines of dead code in the
>> kernel due to this.  So far we've fixed several areas, like tty,
>> x86, net, ... and we continue to work on other areas.
> 
> Just wondering if this is still pending for this merge window; Stefano
> had reviewed the two commits he wanted changed vs. v1 and this v2 was
> sent approximately a month ago w/o any further change requests.

Sorry. While I was checking for pending series for 4.6 I accidentally
looked at v1 and saw outstanding comments and skipped it.

I've now applied this series, thanks.

David
