From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 20 Mar 2015 13:32:32 +0100
Subject: [PATCH 06/35 linux-next] power: constify of_device_id array
In-Reply-To: <1426533469-25458-7-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-7-git-send-email-fabf@skynet.be>
Message-ID: <20150320123231.GB7734@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabian,

On Mon, Mar 16, 2015 at 08:17:12PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Thanks, applied:

http://git.infradead.org/battery-2.6.git/commit/8fb0885504cc029bd48877fa89ba91c33c0110b5

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150320/f070b921/attachment-0001.sig>
