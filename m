From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Jan 2014 16:24:30 +0100
Subject: [PATCH 1/2] drm/panel: Add support for Samsung LTN101NT05 panel
In-Reply-To: <f03a644deb858f10affb7b039f9982bac81b02c9.1387656959.git.marvin24@gmx.de>
References: <f03a644deb858f10affb7b039f9982bac81b02c9.1387656959.git.marvin24@gmx.de>
Message-ID: <20140108152429.GG21974@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 09:38:12PM +0100, Marc Dietrich wrote:
> The Samsung LNT101NT05 10.1" WXVGA panel can be supported by the simple panel
> driver.
> 
> Cc: linux-fbdev at vger.kernel.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> ---
> This isn't strickly required to get the panel up, but Thierry suggested on IRC to
> include it anyway, in case someone else has some use for it.

For the record: the reason this isn't strictly needed is because there's
an EDID that can be probed to get the video timings. But the panel still
can be supported using the timings from the datasheet. One example where
this would be useful is when the EDID isn't connected or simply broken.

That said: applied, thanks!

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/20c2e49f/attachment-0001.sig>
