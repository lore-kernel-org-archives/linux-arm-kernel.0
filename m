From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 27 Nov 2009 21:39:39 +0100
Subject: [PATCH 0/3] pxa_camera: remove init() callback
In-Reply-To: <1258495463-26029-1-git-send-email-ospite@studenti.unina.it>
References: <1258495463-26029-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20091127213939.9bb235fa.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2009 23:04:20 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Hi,
> 
> this series removes the init() callback from pxa_camera_platform_data, and
> fixes its users to do initialization statically at machine init time.
> 
[...]
> Antonio Ospite (3):
>   em-x270: don't use pxa_camera init() callback
>   pcm990-baseboard: don't use pxa_camera init() callback

Eric, if Guennadi ACKs v2 for these two please apply them only, we are
postponing the third one, hence you can discard it.

>   pxa_camera: remove init() callback
> 

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091127/23d5141f/attachment.sig>
