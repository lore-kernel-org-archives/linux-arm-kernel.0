From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 15 Mar 2017 21:45:13 +0100
Subject: [PATCH 1/2] power: reset: syscon-poweroff: add a mask property
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Message-ID: <20170315204513.i3cpl4ptyevtyyp5@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 07, 2017 at 05:56:05PM +0200, Guy Shapiro wrote:
> Make the syscon-poweroff driver accept value and mask instead of
> just value.
> 
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>

Thanks, queued with Rob's Acked-By.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/4cbcea15/attachment.sig>
