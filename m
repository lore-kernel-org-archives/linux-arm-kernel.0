From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 17:29:47 +0100
Subject: [PATCH V3 00/12] CCF support for Renesas r7s72100
In-Reply-To: <2368991.bjBJjms8qn@avalon>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <2368991.bjBJjms8qn@avalon>
Message-ID: <20140307162946.GG28943@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

> Beside the comment to patch 06/12, I would have moved patches 06/12 to 08/12 
> to the beginning of the series, in order to avoid adding a clock workaround 
> for the serial clock only to remove it a couple of patches later.

That would have saved only 2 lines since we need the workaround anyhow
(MTU2) and would break the incremental approach of this series somewhat.
I'd like to keep it.

> Oh, and one might ask you to fix the 80 columns checkpatch warnings for patch 
> 01/12 :-) 

Broken intentionally for the sake of readability :)

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/ffff9de6/attachment.sig>
