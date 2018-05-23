From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 23 May 2018 16:06:20 +0200
Subject: [PATCH 07/24] arm64: ilp32: add documentation on the ILP32 ABI
 for ARM64
In-Reply-To: <20180516081910.10067-8-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-8-ynorov@caviumnetworks.com>
Message-ID: <20180523140620.GA27215@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-05-16 11:18:52, Yury Norov wrote:
> Based on Andrew Pinski's patch-series.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

So Andrew's signoff should be here?

> ---
>  Documentation/arm64/ilp32.txt | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/arm64/ilp32.txt
> 
> diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
> new file mode 100644
> index 000000000000..d0fd5109c4b2
> --- /dev/null
> +++ b/Documentation/arm64/ilp32.txt
> @@ -0,0 +1,45 @@
> +ILP32 AARCH64 SYSCALL ABI
> +=========================
> +
> +This document describes the ILP32 syscall ABI and where it differs
> +from the generic compat linux syscall interface.

I was hoping to learn what ILP32 is / what is it good for, but no,
this does not tell me... it would be good to do a short explanation
here, and maybe reference it from cover letter of the series...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/d09aa9cc/attachment.sig>
