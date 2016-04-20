From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Apr 2016 15:40:36 +0200
Subject: [PATCH v2] drm/panel: simple: Add support for Innolux AT070TN92
In-Reply-To: <1461159435-16528-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1461159435-16528-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160420134036.GA7470@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 03:37:15PM +0200, Boris Brezillon wrote:
> From: Riccardo Bortolato <bortolato@navaltechitalia.it>
> 
> Add support for the Innolux AT070TN92 panel.
> 
> Signed-off-by: Riccardo Bortolato <bortolato@navaltechitalia.it>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> ---
> Changes since v1:
> - Add missing SoB
> ---
>  .../bindings/display/panel/innolux,at070tn92.txt   |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,at070tn92.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160420/f4e71d52/attachment-0001.sig>
