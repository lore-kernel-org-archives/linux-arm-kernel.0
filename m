From: emunson@akamai.com (Eric B Munson)
Date: Wed, 22 Jul 2015 10:05:02 -0400
Subject: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
In-Reply-To: <55AF5F5A.3000707@suse.cz>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <55AF5F5A.3000707@suse.cz>
Message-ID: <20150722140502.GB2859@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jul 2015, Vlastimil Babka wrote:

> On 07/21/2015 09:59 PM, Eric B Munson wrote:
> >With the refactored mlock code, introduce new system calls for mlock,
> >munlock, and munlockall.  The new calls will allow the user to specify
> >what lock states are being added or cleared.  mlock2 and munlock2 are
> >trivial at the moment, but a follow on patch will add a new mlock state
> >making them useful.
> >
> >munlock2 addresses a limitation of the current implementation.  If a
> 
>   ^ munlockall2?

Fixed, thanks.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150722/571709e3/attachment.sig>
