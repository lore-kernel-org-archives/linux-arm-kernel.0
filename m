From: riel@redhat.com (Rik van Riel)
Date: Wed, 20 Jul 2016 12:22:07 -0400
Subject: [PATCH v3 00/11] mm: Hardened usercopy
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4FEA62@AcuExch.aculab.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <063D6719AE5E284EB5DD2968C1650D6D5F4FD6A3@AcuExch.aculab.com>
 <CAGXu5j+QH8Fdk7p6bZV_yMv1puHRxZRu5z45+tKrmLyGBTymFw@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4FEA62@AcuExch.aculab.com>
Message-ID: <1469031727.30053.71.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-20 at 16:02 +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 20 July 2016 16:32
> ...
> > Yup: that's exactly what it's doing: walking up the stack. :)
> 
> Remind me to make sure all our customers run kernels with it
> disabled.

You want a single copy_from_user to write to data in
multiple stack frames?

-- 

All Rights Reversed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160720/8149e731/attachment.sig>
