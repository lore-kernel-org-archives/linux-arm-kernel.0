From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Dec 2016 16:46:25 +0100
Subject: [RFC PATCH v3 2/2] drm/panel: Add support for Chunghwa
 CLAA070WP03XG panel
In-Reply-To: <1474311771-23321-3-git-send-email-ayaka@soulik.info>
References: <1474311771-23321-1-git-send-email-ayaka@soulik.info>
 <1474311771-23321-3-git-send-email-ayaka@soulik.info>
Message-ID: <20161206154625.GA28534@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 03:02:51AM +0800, Randy Li wrote:
> The Chunghwa CLAA070WP03XG is a 7" 1280x800 panel, which can be
> supported by the simple panel driver.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  .../display/panel/chunghwa,claa070wp03xg.txt       |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/chunghwa,claa070wp03xg.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161206/1e6499f1/attachment.sig>
