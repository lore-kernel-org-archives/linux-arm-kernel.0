From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 25 Aug 2014 11:37:01 +0200
Subject: [PATCH 1/2] i2c: cros-ec-tunnel: Add of match table
In-Reply-To: <1408748582-29029-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1408748582-29029-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1408748582-29029-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CABxcv==yuxBmed5pZMwfQTXkwpbW1WkXw58tLsBF16BH60-jAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sjoerd,

On Sat, Aug 23, 2014 at 1:03 AM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> To enable the cros-ec-tunnel driver to be auto-loaded when build as a
> module add an of match table (and export it) to match the modalias
> information passed on to userspace as the Cros EC MFD driver registers
> the MFD subdevices with an of_compatibility string.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---

Looks good to me:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
