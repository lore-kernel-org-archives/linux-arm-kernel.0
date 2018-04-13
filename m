From: jhogan@kernel.org (James Hogan)
Date: Sat, 14 Apr 2018 00:52:18 +0100
Subject: [PATCH v4 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
References: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
 <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
 <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
Message-ID: <20180413235217.GA19138@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 10:33:42PM -0400, Sinan Kaya wrote:
> On 4/12/2018 10:30 PM, Sinan Kaya wrote:
> > +	/* prevent prefetching of coherent DMA dma prematurely */	\
> 
> I tried to write DMA data but my keyboard is not cooperating. I'll hold onto
> posting another version until I hear back from you for wmb().

No problem, I've applied both for 4.17 and tweaked the comment.

Thanks
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180414/a3da563c/attachment.sig>
